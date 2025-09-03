import 'dart:io';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_college.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_contact.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/personal_data.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:image_picker/image_picker.dart';

class MyprofileProvider with ChangeNotifier {

  bool _isVisiblePass = false;
  bool _isLoading = false;
  bool _isVisiblePassRepeat = false;

  static final MyprofileProvider _instance = MyprofileProvider._internal();
  factory MyprofileProvider() => _instance;
  MyprofileProvider._internal();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // Provider.of<AuthProvider>(context, listen: false);
  

  TextEditingController ctrlPassword = TextEditingController();
  TextEditingController ctrlPasswordToConfirm = TextEditingController();
  TextEditingController ctrlFullName = TextEditingController(text: 'Jospe Guevara Martine');
  TextEditingController ctrlDni = TextEditingController(text: '23438734');
  TextEditingController ctrlAge = TextEditingController(text: '26');
  TextEditingController ctrlGender = TextEditingController(text: 'Masculino');
  TextEditingController ctrlCivilState = TextEditingController(text: 'Soltero');
  TextEditingController ctrlBirthdate = TextEditingController(text: '23/07/1999');
  TextEditingController ctrlAddress = TextEditingController(text: 'Av. Faucet 213');
  TextEditingController ctrlPhoneNumber = TextEditingController(text: '972 345 231');
  TextEditingController ctrlEmail = TextEditingController(text: 'software@gmail.com');
  TextEditingController ctrlCipNumber = TextEditingController(text: '2889349');
  TextEditingController ctrlEntryDate = TextEditingController(text: '23/07/2020');
  TextEditingController ctrlQuantityAge = TextEditingController(text: '05');

   set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  set isVisiblePass(bool value) {
    _isVisiblePass = value;
    notifyListeners();
  }
  set isVisiblePassRepeat(bool value) {
    _isVisiblePassRepeat = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isVisiblePass => _isVisiblePass;
  bool get isVisiblePassRepeat => _isVisiblePassRepeat;
  
  //VARIABLES
  // final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  File? get profileImage => _profileImage;

  //INSTANCIAS

  //FUNCIONES
  // Método para seleccionar imagen desde la galería
  Future<void> pickImageFromGallery() async {
    // final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // if (pickedFile != null) {
    //   _profileImage = File(pickedFile.path);
    //   notifyListeners();  // Notifica a los widgets que usan este controlador
    // }
  }

  Future goToPersonalData(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalData()));
  }
  Future goToPersonalContact(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalContact()));
  }
  Future goToPersonalCollege(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalCollege()));
  }
  
  
}
