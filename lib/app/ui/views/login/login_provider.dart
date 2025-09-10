import "package:cip_payment_web/app/providers/auth_provider.dart";
import "package:cip_payment_web/app/ui/components/toast/toast.dart";
import "package:cip_payment_web/core/helpers/custom_snackbar.dart";
import "package:cip_payment_web/routes/app_routes_name.dart";
import "package:cip_payment_web/services/firebase/auth_service.dart";
import "package:cip_payment_web/services/firebase/person_service.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import 'package:web/web.dart' as web;

class LoginProvider with ChangeNotifier {
  final authService = AuthService();
  final PersonService personService = PersonService();
  int counter = 0;
  TextEditingController ctrlUserName = TextEditingController(text: '');//  Jose wilmer123
  TextEditingController ctrlPassword = TextEditingController(text: '');// Jose123 wilmer123
  TextEditingController ctrlDni = TextEditingController(text: '12345678');
  TextEditingController ctrlName = TextEditingController(
    text: 'JOSE GUEVARA MARTINEZ',
  );
  TextEditingController ctrlEmail2 = TextEditingController(
    text: 'software@ciplambayeque.com',
  );

  bool _isVisibleIcon = true;
  bool _rememberPass = false;
  bool _isAuthenticating = false;

  set isAuthenticating(bool value) {
    _isAuthenticating = value;
    notifyListeners();
  }

  set isVisibleIcon(bool value) {
    _isVisibleIcon = value;
    notifyListeners();
  }

  set rememberPass(bool value) {
    _rememberPass = value;
    notifyListeners();
  }

  bool get rememberPass => _rememberPass;
  bool get isVisibleIcon => _isVisibleIcon;
  bool get isAuthenticating => _isAuthenticating;

  Future<void> authentication(BuildContext context) async {
    isAuthenticating = true;
    try{
      if(ctrlUserName.text.isEmpty && ctrlPassword.text.isEmpty){
      showToastGlobal(
        context,
        2,
        "info",
        "Ingresar usuario y contraseña.",
      );
      return;
    }
    if (ctrlUserName.text.isEmpty){
      showToastGlobal(
        context,
        2,
        "info",
        "Ingresar usuario.",
      );
      return;
    }
    if (ctrlPassword.text.isEmpty){
      showToastGlobal(
        context,
        2,
        "info",
        "Ingresar contraseña.",
      );
      return;
    }
    
    
    String? personId = await authService.loginUser(
      ctrlUserName.text.trim().toLowerCase(),
      ctrlPassword.text.trim(),
    );
    isAuthenticating = false;
    if (personId == null) {
       showToastGlobal(
        context,
        2,
        "info",
        "Usuario o contraseña incorrecta.",
      );
      return;
    }
    final person = await personService.getPersonById(personId);

    if (person != null) {
      Provider.of<AuthProvider>(context, listen: false).setPerson(person);
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).setBirthDate(person.dateBirth);
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).setEntryDate(person.dataEntryPerson);
    }
    if (kIsWeb) {
      if (person?.isAdmin == true) {
        context.go(AppRoutesName.LAYOUT);
        // web.window.history.replaceState(null, 'Home', '#/home');
      } else {
        context.go(AppRoutesName.HOME);
        web.window.history.replaceState(null, 'Home', '#/home');
      }
    } else {
      context.go(AppRoutesName.HOME);
    }

    }catch(e){

    }finally{
      isAuthenticating = false;
    }
    
  }
}
