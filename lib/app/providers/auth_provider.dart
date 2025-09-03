import 'package:cip_payment_web/app/models/person_model.dart';
import 'package:cip_payment_web/preferences/shared_preferences.dart';
import 'package:cip_payment_web/services/firebase/person_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  
  PersonModel? _currentPerson;
  DateTime? _birthDate;
  DateTime? _entryDate;
  
  DateTime? get birthDate => _birthDate;
  PersonModel? get currentPerson => _currentPerson;

  void setPerson(PersonModel person) async{
    _currentPerson = person;
    PreferencesUser.personId = person.id; // se guarda directo
    notifyListeners();
  }
  Future<void> loadPerson() async {
    final id = PreferencesUser.personId;
    if (id.isNotEmpty) {
      _currentPerson = await PersonService().getPersonById(id);
      notifyListeners();
    }
      
  }

  void notifyChange() {
    notifyListeners();
  }

  void setBirthDate(Timestamp timeStamp) {
    DateTime date = timeStamp.toDate();
    _birthDate = date;
    notifyListeners();
  }

  void setEntryDate(Timestamp timeStamp) {
    DateTime date = timeStamp.toDate();
    _entryDate = date;
    notifyListeners();
  }
  int? get age {
    if (_birthDate == null) return null;

    final today = DateTime.now();
    int age = today.year - _birthDate!.year;

    // Ajustar si todavía no ha cumplido años este año
    if (today.month < _birthDate!.month ||
        (today.month == _birthDate!.month && today.day < _birthDate!.day)) {
      age--;
    }
    return age;
  }

  int? get yearsOfMembership {
    if (_entryDate == null) return null;

    final today = DateTime.now();
    int age = today.year - _entryDate!.year;

    // Ajustar si todavía no ha cumplido años este año
    if (today.month < _entryDate!.month ||
        (today.month == _entryDate!.month && today.day < _entryDate!.day)) {
      age--;
    }
    return age;
  }

  String get birthDateFormatted {
    if (_birthDate == null) return '';
    return DateFormat('dd/MM/yyyy').format(_birthDate!);
  }

  void logout() {
    _currentPerson = null;
    notifyListeners();
  }
}
