import 'package:cip_payment_web/app/models/person_model.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/services/firebase/person_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PersonProvider with ChangeNotifier {
  final personService = PersonService();

  TextEditingController dni = TextEditingController(text: '');
  TextEditingController address = TextEditingController(text: '');
  TextEditingController civilStatus = TextEditingController(text: '');
  TextEditingController dateBirth = TextEditingController(text: '');
  TextEditingController emailMain = TextEditingController(text: '');
  TextEditingController emailSecondary = TextEditingController(text: '');
  TextEditingController genderPerson = TextEditingController(text: '');
  TextEditingController imagePerson = TextEditingController(text: '');
  TextEditingController motherSurname = TextEditingController(text: '');
  TextEditingController nacionality = TextEditingController(text: '');
  TextEditingController namePerson = TextEditingController(text: '');
  TextEditingController numberCip = TextEditingController(text: '');
  TextEditingController numberPhone = TextEditingController(text: '');
  TextEditingController paternalSurname = TextEditingController(text: '');
  TextEditingController personId = TextEditingController(text: '');
  TextEditingController ruc = TextEditingController(text: '');
  TextEditingController specialityId = TextEditingController(text: '');

  TextEditingController searchFullName = TextEditingController(text: '');
  TextEditingController searchDni = TextEditingController(text: '');
  TextEditingController searchBySpecialty = TextEditingController(text: '');

  Future<void> newPerson(BuildContext context) async {
    try {
      final response = await personService.createPerson(
        PersonModel(
          id: '',
          address: address.text,
          civilStatus: civilStatus.text,
          dataEntryPerson: Timestamp.fromDate(DateTime.now()),
          dateBirth: Timestamp.fromDate(DateTime.now()),
          dni: dni.text,
          emailMain: emailMain.text,
          emailSecondary: emailSecondary.text,
          genderPerson: genderPerson.text,
          imagePerson: imagePerson.text,
          motherSurname: motherSurname.text,
          nacionality: nacionality.text,
          namePerson: namePerson.text,
          numberCip: numberCip.text,
          numberPhone: numberPhone.text,
          paternalSurname: paternalSurname.text,
          personId: '',
          ruc: ruc.text,
          statePerson: true,
        ),
      );
      if (response.isNotEmpty) {
        showToastGlobal(
          context,
          0,
          "success",
          "La persona fue guardada correctamente.",
        );
        cleanValuesBeforeCreate();
        context.pop();
        return;
      }
      showToastGlobal(context, 1, "error", kmessageErrorGeneral);
    } catch (e) {
      showToastGlobal(context, 1, "error", kmessageErrorGeneral + e.toString());
    } finally {}
  }

  List<PersonModel> listPersons = [];
  Future<void> getAllPerson() async {
    try {
      final response = await personService.fetchAllPersons();

      if (response.isNotEmpty) {
        listPersons = response;
      }
      print('get persons');
      print(listPersons.length);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
  }

  void cleanSearch() {
    searchFullName.text = '';
    searchDni.text = '';
    searchBySpecialty.text = '';
  }

  void cleanValuesBeforeCreate() {
    dni.text = '';
    address.text = '';
    civilStatus.text = '';
    dateBirth.text = '';
    emailMain.text = '';
    emailSecondary.text = '';
    genderPerson.text = '';
    imagePerson.text = '';
    motherSurname.text = '';
    nacionality.text = '';
    namePerson.text = '';
    numberCip.text = '';
    numberPhone.text = '';
    paternalSurname.text = '';
    personId.text = '';
    ruc.text = '';
    specialityId.text = '';
  }
}
