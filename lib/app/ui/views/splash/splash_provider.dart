
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashProvider with ChangeNotifier{
  String username = '';
  String password = '';
  String personalId = '';
  String srememberPass = '';
  String fullName = '';
  String names = '';
  String lastName = '';

  bool isInitialized = false;
  
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(); 
  // final GeneralProvider generalProvider = GeneralProvider();
  
  Future<void> initialize(BuildContext context) async {
    if(isInitialized) return;
    try{
    username = await secureStorage.read(key: 'kUserName') ?? '';
    password = await secureStorage.read(key: 'kPassword') ?? '';
    personalId = await secureStorage.read(key: 'kIdUser') ?? '';
    srememberPass = await secureStorage.read(key: 'kRemenberPass') ?? '';
    
    // notifyListeners();
    // if (username.isNotEmpty && password.isNotEmpty){
    //   final response =  await generalProvider.postLogin(RequestLoginModel(username: username, password: password));
    //   if (!response.success) {
    //     Helpers.goToLoginRemoveUntil(context);
    //     return;
    //   }
    //   DataPersonal responsedata = response.data![0];
    //   await secureStorage.write(key: Keys.kPassword, value: password);
    //   await secureStorage.write(key: Keys.kIdUser, value: responsedata.personalId);
    //   await secureStorage.write(key: Keys.kIdRole, value: responsedata.personalRol);
    //   await secureStorage.write(key: Keys.kNameUser, value: responsedata.personalNombreCompleto);
    //   await secureStorage.write(key: Keys.kEmail, value: responsedata.personalCorreo);
    //   names = responsedata.personalNombres ?? ''; 
    //   lastName = responsedata.personalApellidos ?? '' ;
    //   Helpers.goToHomeRemoveUntil(context);
    //   return;
    // }
    context.go(AppRoutesName.LOGIN);
    
    
    }catch(e){

    }finally{
      isInitialized = true;
      notifyListeners();
    }
  }

}