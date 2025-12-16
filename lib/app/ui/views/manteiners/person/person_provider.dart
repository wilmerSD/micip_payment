import 'dart:math';

import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/domain/entities/person.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:cip_payment_web/infrastructure/datasources/persondb_datasource.dart';
import 'package:cip_payment_web/infrastructure/datasources/specialitydb_datasource.dart';
import 'package:cip_payment_web/infrastructure/models/person_model.dart';
import 'package:cip_payment_web/infrastructure/models/personspeciality_model.dart';
import 'package:cip_payment_web/infrastructure/models/select_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/person_repository_impl.dart';
import 'package:cip_payment_web/infrastructure/repositories/speciality_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PersonProvider with ChangeNotifier {
  final PersonRepositoryImpl persondbDatasource = PersonRepositoryImpl(
    PersondbDatasource(),
  );
  final SpecialityRepositoryImpl specialityRepositoryImpl =
      SpecialityRepositoryImpl(SpecialitydbDatasource());
  final random = Random();

  TextEditingController dni = TextEditingController(text: ''); //8 digitos
  TextEditingController address = TextEditingController(text: '');
  TextEditingController emailMain = TextEditingController(text: '');
  TextEditingController emailSecondary = TextEditingController(text: '');
  TextEditingController namePerson = TextEditingController(text: '');
  TextEditingController motherSurname = TextEditingController(text: '');
  TextEditingController paternalSurname = TextEditingController(text: '');
  TextEditingController numberCip = TextEditingController(
    text: '',
  ); //10 digitos
  TextEditingController numberPhone = TextEditingController(
    text: '',
  ); //9 digitos

  TextEditingController nacionality = TextEditingController(text: 'Peruana');
  TextEditingController ruc = TextEditingController(text: '');
  TextEditingController dateBirth = TextEditingController(text: '');
  TextEditingController imagePerson = TextEditingController(text: '');

  TextEditingController searchFullName = TextEditingController(text: '');
  TextEditingController searchDni = TextEditingController(text: '');
  TextEditingController searchMainEmail = TextEditingController(text: '');
  TextEditingController searchBySpecialty = TextEditingController(text: '');

  List<SelectModel> listGender = [
    SelectModel(id: '0', value: 'Masculino'),
    SelectModel(id: '1', value: 'Femenino'),
  ];
  SelectModel currentGender = SelectModel(id: '0', value: 'Seleccionar');

  List<SelectModel> listCivilState = [
    SelectModel(id: '0', value: 'Soltero(a)'),
    SelectModel(id: '1', value: 'Casado(a)'),
    SelectModel(id: '2', value: 'Viudo(a)'),
    SelectModel(id: '3', value: 'Viudo(a)'),
    SelectModel(id: '4', value: 'Conviviente(a)'),
  ];
  SelectModel currentCivilState = SelectModel(id: '0', value: 'Soltero(a)');

  String personId = '';
  String mainEmail = '';
  Future<void> onInit() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
    getSpecilaities();
    getAllPerson();
  }

  void initVariables() {
    dni.text = List.generate(8, (_) => random.nextInt(10)).join(); //8 digitos
    address.text = listAddress[random.nextInt(listAddress.length)];
    emailMain.text = listMainEmails[random.nextInt(listMainEmails.length)];
    emailSecondary.text =
        listSecondEmails[random.nextInt(listSecondEmails.length)];
    namePerson.text = listNames[random.nextInt(listNames.length)];
    motherSurname.text =
        listMotherSurname[random.nextInt(listMotherSurname.length)];
    paternalSurname.text =
        listPaternalSurname[random.nextInt(listPaternalSurname.length)];
    numberCip.text = List.generate(10, (_) => random.nextInt(10)).join();
    numberPhone.text = '9' + List.generate(8, (_) => random.nextInt(10)).join();
  }

  Future<void> newPerson(BuildContext context) async {
    try {
      final response = await persondbDatasource.createPerson(
        PersonModel(
          id: '',
          address: address.text,
          civilStatus: currentCivilState.value,
          dataEntryPerson: Timestamp.fromDate(DateTime.now()),
          dateBirth: Timestamp.fromDate(DateTime.now()),
          dni: dni.text,
          emailMain: emailMain.text,
          emailSecondary: emailSecondary.text,
          genderPerson: currentGender.value,
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
          specialityId: currectSpecialty.id,
          isAdmin: false,
        ),
      );

      if (response != null) {
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

  List<Person> listPersons = [];
  Future<void> getAllPerson() async {
    listPersons.clear();
    try {
      final response = await persondbDatasource.fetchAllPersons(
        searchMainEmail.text,
        searchDni.text,
        searchFullName.text,
      );

      if (response.isNotEmpty) {
        listPersons.addAll(response);
      }
      print('get persons');
      print(listPersons.length);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<Speciality> listSpecialities = [];
  SelectModel currectSpecialty = SelectModel(id: '0', value: 'Seleccionar');

  Future<void> getSpecilaities() async {
    listSpecialities.clear();
    final response = await specialityRepositoryImpl.getSpecialties('');
    print('cantidad de especialidades');
    print(response.length);
    listSpecialities.addAll(response);
    if (response.isNotEmpty && currectSpecialty.id == '0') {
      final first = listSpecialities.first;
      currectSpecialty = SelectModel(
        id: first.id ?? '',
        value: first.nameSpeciality ?? '',
      );
    }
    notifyListeners();
  }

  void cleanSearch() {
    searchFullName.text = '';
    searchDni.text = '';
    searchBySpecialty.text = '';
  }

  void cleanValuesBeforeCreate() {
    dni.text = '';
    address.text = '';
    dateBirth.text = '';
    emailMain.text = '';
    emailSecondary.text = '';
    imagePerson.text = '';
    motherSurname.text = '';
    nacionality.text = '';
    namePerson.text = '';
    numberCip.text = '';
    numberPhone.text = '';
    paternalSurname.text = '';
    ruc.text = '';
  }

  TextEditingController personIdToEdit = TextEditingController(
    text: '',
  ); //8 digitos
  void toEditPerson(Person person) {
    print("imprimiendo personId: " + person.personId);
    personIdToEdit.text = person.id;
  }

  void pruebaBuscarEspecialidadPerson() {
    final response = persondbDatasource.pruebaBuscarEspecialidadPerson(
      searchBySpecialty.text,
    );
  }

  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;
  TextEditingController personIdToCreate = TextEditingController(
    text: '',
  ); //8 digitos
  TextEditingController specialityIdtoCreate = TextEditingController(
    text: '',
  ); //8 digitos
  Future<void> createPersonSpeciality() async {
    try {
      final personId = personIdToCreate.text.trim();
      final specialityId = specialityIdtoCreate.text.trim();

      // 1️⃣ Verificar si ya existe un registro con ese personId
      final querySnapshot = await firestoredb
          .collection('PersonSpeciality')
          .where('personId', isEqualTo: personId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        debugPrint(
          '⚠️ Ya existe un registro con ese personId. No se creará otro.',
        );
        return; // No crear duplicado
      }

      // 2️⃣ Si no existe, creamos el nuevo registro
      final personSpeciality = PersonspecialityModel(
        personId: personId,
        specialityId: specialityId,
      );

      await firestoredb
          .collection('PersonSpeciality')
          .add(personSpeciality.toJson());

      debugPrint('✅ Registro creado correctamente.');
    } catch (e) {
      debugPrint('❌ Error al crear PersonSpeciality: $e');
    }
  }

  final listNames = [
    'Ana Paola',
    'Luis',
    'María Angie',
    'Carlos Jean',
    'Sofía',
    'Andrés',
    'Lucía',
    'Mateo',
    'Valentina',
    'Javier',
    'Camila',
    'Sebastián',
    'Fernanda',
    'Diego',
    'Paula',
    'Gabriel',
    'Isabella',
    'Tomás',
    'Daniela',
    'Felipe',
    'Victoria',
    'Emilio',
    'Romina',
    'Martín',
    'Sara',
    'Julio',
    'Claudia',
    'Iván',
    'Carmen',
    'Adrián',
    'Elena',
    'Rodrigo',
    'Diana',
    'Ricardo',
    'Patricia',
    'Enzo',
    'Bianca',
    'Leonardo',
    'Mónica',
    'Gustavo',
    'Florencia',
    'Alonso',
    'Ángela',
    'Francisco',
    'Vanessa',
    'Eduardo',
    'Rosa',
    'Joaquín',
    'Lorena',
    'Raúl',
    'Natalia',
    'Pablo',
    'Marina',
    'Héctor',
    'Alejandra',
    'Renzo',
    'Karina',
    'Hugo',
    'Beatriz',
    'César',
    'Brenda',
    'Joel',
    'Tamara',
    'Oscar',
    'Marisol',
    'Cristian',
    'Andrea',
    'Santiago',
    'Nicole',
    'Juliana',
    'Samuel',
    'Melanie',
    'Alan',
    'Cecilia',
    'Álvaro',
    'Gabriela',
    'Bastián',
    'Fabiola',
    'Erick',
    'Tatiana',
    'Noelia',
    'Alexis',
    'Camilo',
    'Mónica Alejandra',
    'Emanuel',
    'Milagros',
    'Bryan',
    'Silvana',
    'Marco',
    'Mariela',
    'Leonel',
    'Lisbeth',
    'Esteban',
    'Carolina',
    'Rafael',
    'Martha',
    'Félix',
    'Verónica',
  ];

  final listPaternalSurname = [
    'Santos',
    'García',
    'Pérez',
    'Rodríguez',
    'López',
    'Martínez',
    'Fernández',
    'Gómez',
    'Díaz',
    'Ruiz',
    'Torres',
    'Ramírez',
    'Flores',
    'Acosta',
    'Mendoza',
    'Romero',
    'Rojas',
    'Castro',
    'Morales',
    'Jiménez',
    'Silva',
    'Ortega',
    'Cruz',
    'Suárez',
    'Guerrero',
    'Pineda',
    'Reyes',
    'Campos',
    'Delgado',
    'Vargas',
    'Molina',
    'Ramos',
    'Carrillo',
    'Aguilar',
    'Peña',
    'Navarro',
    'Serrano',
    'Salazar',
    'Rivas',
    'Escobar',
    'Herrera',
    'Mejía',
    'Valenzuela',
    'Rosales',
    'Medina',
    'Palacios',
    'Pacheco',
    'Arroyo',
    'Velasco',
    'Alvarado',
    'Sandoval',
    'Montoya',
    'Luna',
    'Quiroz',
    'Palma',
    'Benítez',
    'Bravo',
    'Tapia',
    'Espinoza',
    'Campos',
    'Guevara',
    'Solís',
    'Barrios',
    'Huerta',
    'Mora',
    'Núñez',
    'Pizarro',
    'Cordero',
    'Toledo',
    'Lara',
    'Peralta',
    'Cornejo',
    'Arias',
    'Valverde',
    'Fuentes',
    'Del Valle',
    'Lagos',
    'Soria',
    'Muñoz',
    'Cuenca',
    'Sánchez',
    'Arce',
    'Maldonado',
    'Camposano',
    'Quispe',
    'Ramallo',
    'Paz',
    'Lozano',
    'Reynoso',
    'Gallo',
    'Altamirano',
    'Camacho',
    'Cáceres',
    'Bustamante',
    'Rosado',
    'Montes',
    'Reátegui',
    'Urbina',
    'Gallardo',
    'Oliva',
  ];
  final listMotherSurname = [
    'Díaz',
    'Morales',
    'Ramírez',
    'Flores',
    'Guzmán',
    'Castillo',
    'Reyes',
    'Cabrera',
    'Ortiz',
    'Jiménez',
    'Salinas',
    'Espinoza',
    'Campos',
    'Navarro',
    'Cáceres',
    'Valdez',
    'Gálvez',
    'Maldonado',
    'Pizarro',
    'Mejía',
    'Vásquez',
    'Herrera',
    'Romero',
    'Huamán',
    'Silva',
    'Zamora',
    'Torres',
    'Ríos',
    'Quintana',
    'Córdova',
    'Ponce',
    'Aguilar',
    'Soto',
    'Rosales',
    'Villanueva',
    'Escalante',
    'Bravo',
    'Vergara',
    'Tapia',
    'Castro',
    'Guerra',
    'Loayza',
    'Camposano',
    'Luján',
    'Paredes',
    'Zúñiga',
    'Moreno',
    'Camacho',
    'Lozano',
    'Quiroz',
    'Rivas',
    'Bermúdez',
    'Velásquez',
    'Bautista',
    'Santos',
    'Cruz',
    'Medina',
    'Arévalo',
    'Benavides',
    'Guevara',
    'Palacios',
    'Vega',
    'Nieves',
    'Mora',
    'Trujillo',
    'Delgado',
    'Fuentes',
    'Montes',
    'Saldaña',
    'Pereda',
    'Carrasco',
    'Acosta',
    'Villalobos',
    'Rojas',
    'Andrade',
    'Serrano',
    'Olivares',
    'Rosado',
    'Palma',
    'Meléndez',
    'Cáceres',
    'Pizarro',
    'Villar',
    'Chávez',
    'Rentería',
    'Pérez',
    'Gonzales',
    'Gálvez',
    'Tello',
    'Escobar',
    'Blanco',
    'Sáenz',
    'Reátegui',
    'Quiñones',
    'Portilla',
    'Marín',
    'León',
    'Bravo',
    'Cárdenas',
  ];
  final listMainEmails = List.generate(100, (i) => 'usuario${i + 1}@gmail.com');
  final listSecondEmails = List.generate(
    100,
    (i) => 'user${i + 1}@outlook.com',
  );
  final listAddress = [
    'Av. Los Álamos 123',
    'Jr. Lima 456',
    'Calle Puno 789',
    'Av. Arequipa 1020',
    'Jr. Cuzco 580',
    'Pasaje Olivos 33',
    'Av. Primavera 905',
    'Calle Los Sauces 14',
    'Jr. Huancayo 234',
    'Av. Grau 987',
    'Calle Las Flores 120',
    'Av. San Martín 412',
    'Jr. Amazonas 777',
    'Av. Universitaria 1400',
    'Av. Progreso 521',
    'Jr. Los Jazmines 808',
    'Calle Miraflores 102',
    'Av. Central 600',
    'Calle Libertad 350',
    'Av. Los Cedros 99',
    'Av. Perú 1002',
    'Av. Los Incas 800',
    'Jr. San Pedro 77',
    'Av. La Cultura 1201',
    'Calle Real 405',
    'Pasaje Los Rosales 65',
    'Av. Las Palmeras 1500',
    'Av. Los Laureles 901',
    'Av. Los Pinos 606',
    'Jr. Ancash 250',
    'Calle San José 88',
    'Av. Tupac Amaru 450',
    'Av. Bolívar 555',
    'Calle Santa Rosa 234',
    'Av. La Marina 321',
    'Av. Los Olivos 412',
    'Jr. Cajamarca 321',
    'Calle Los Álamos 210',
    'Av. Cusco 1300',
    'Calle Los Claveles 54',
    'Av. El Sol 999',
    'Jr. Arequipa 155',
    'Calle Los Robles 11',
    'Av. Brasil 444',
    'Av. Las Gardenias 313',
    'Jr. San Martín 212',
    'Av. Los Ángeles 808',
    'Calle Las Violetas 65',
    'Pasaje Santa Ana 33',
    'Av. Los Laureles 110',
    'Calle Amazonas 87',
    'Av. Miraflores 902',
    'Av. San Luis 103',
    'Calle Los Tulipanes 41',
    'Av. Los Nogales 700',
    'Jr. Bolognesi 134',
    'Av. Piura 601',
    'Calle Independencia 17',
    'Av. Salaverry 222',
    'Av. La Paz 765',
    'Jr. Trujillo 540',
    'Av. San Isidro 855',
    'Av. Cajamarca 560',
    'Calle Los Laureles 48',
    'Av. Progreso 77',
    'Jr. Cusco 650',
    'Av. Lima 930',
    'Calle San Juan 32',
    'Av. Los Alisos 80',
    'Jr. Amazonas 315',
    'Calle San Pablo 103',
    'Av. Arequipa 760',
    'Calle Las Orquídeas 900',
    'Av. Central 210',
    'Jr. Tacna 122',
    'Av. Los Fresnos 620',
    'Calle Miramar 40',
    'Av. Panamericana 330',
    'Calle Libertad 710',
    'Av. Primavera 190',
    'Calle Huancavelica 202',
    'Av. Los Castaños 12',
    'Av. Los Olmos 450',
    'Calle La Unión 33',
    'Jr. Piura 140',
    'Av. Amazonas 999',
    'Calle Las Lomas 512',
    'Av. San Borja 310',
    'Calle Los Pinos 89',
    'Av. Los Girasoles 420',
    'Calle San Pedro 59',
    'Av. Cusco 777',
    'Jr. Moquegua 33',
    'Av. Los Héroes 222',
    'Calle Santa María 19',
    'Av. Las Camelias 606',
    'Calle Los Cedros 117',
    'Av. San Carlos 88',
    'Av. Pardo 612',
    'Calle Los Álamos 300',
    'Av. Los Rosales 50',
    'Calle Los Olivos 70',
  ];
}
