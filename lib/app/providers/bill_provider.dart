import 'package:cip_payment_web/core/helpers/constant.dart';
import 'package:cip_payment_web/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/datasources/invoice_datasource.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/invoice_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BillProvider with ChangeNotifier {
  // Aquí puedes definir tus controladores y lógica de negocio
  // por ejemplo, para manejar el estado de los campos del formulario de la factura.
  final InvoiceRepositoryImpl invoiceRepositoryImpl =
      InvoiceRepositoryImpl(InvoicedbDatasource());
  TextEditingController ctrlRuc = TextEditingController();
  TextEditingController ctrlCompanyName = TextEditingController();
  TextEditingController ctrlAddress = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPhoneNumber = TextEditingController();

  TextEditingController ctrlIndustry = TextEditingController();
  TextEditingController ctrlDepartment = TextEditingController();
  TextEditingController ctrlDistrict = TextEditingController();

  String personId = '';
  String mainEmail = '';
  String companyIdToEdit = '';
  bool isGettingRucs = true;
  List<Company> listCompanies = [];
  Future<void> onInit(BuildContext context) async {
    await getDataPerson(context);
    getRucs();
  }

  Future<void> getDataPerson(BuildContext context) async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
  }

  Future<void> getRucs() async {
    print('hola1');
    isGettingRucs = true;
    listCompanies.clear();
    try {
      final response = await invoiceRepositoryImpl.getRucs(personId);
      listCompanies.addAll(response);
      // print(listCompanies[0].address);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingRucs = false;
      notifyListeners();
    }
  }

  bool isSaving = false;
  Future<void> registerRuc(BuildContext context) async {
    isSaving = true;
    if(ctrlRuc.text.isEmpty){
       CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Validar',
        message: 'Ingresar ruc',
        type: 2,
        time: 2,
      );
      return;
    }
    try {
      final response = await invoiceRepositoryImpl.createRuc(CompanyModel(
        address: ctrlAddress.text,
        businessName: ctrlCompanyName.text,
        createdAt: Timestamp.fromDate(DateTime.now()),
        email: ctrlEmail.text,
        personId: personId,
        phone: ctrlPhoneNumber.text,
        ruc: ctrlRuc.text,
        status: true,
        tradeName: ctrlCompanyName.text,
        updatedAt: Timestamp.fromDate(DateTime.now()),
      ));
      if (response == null) {
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Error',
          message:
              'Ocurrio un error al tratar guardar su ruc. Por favor intente nuevamente',
          type: 2,
          time: 2,
        );
        return;
      }
      await getRucs();
      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: messageErrorBadRequest,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateRuc(BuildContext context) async {
    isSaving = true;
    try {
      final response = await invoiceRepositoryImpl.updateRuc(CompanyModel(
        id: companyIdToEdit,
        address: ctrlAddress.text,
        businessName: ctrlCompanyName.text,
        createdAt: Timestamp.fromDate(DateTime.now()),
        email: ctrlEmail.text,
        personId: personId,
        phone: ctrlPhoneNumber.text,
        ruc: ctrlRuc.text,
        status: true,
        tradeName: ctrlCompanyName.text,
        updatedAt: Timestamp.fromDate(DateTime.now()),
      ));
      if (response == null) {
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Error',
          message:
              'Ocurrio un error al tratar actualizar su ruc. Por favor intente nuevamente',
          type: 2,
          time: 2,
        );
        return;
      }
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Éxito',
        message: 'Compania actualizado con éxito',
        type: 3,
        time: 2,
      );
      Navigator.pop(context);
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: messageErrorBadRequest,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      isSaving = false;
      companyIdToEdit = '';
    }
  }

  bool isDeletingRuc = false;
  Future<void> deleteRuc(BuildContext context, String companyId) async {
    isDeletingRuc = true;
    print(companyId);
    try {
      final response = await invoiceRepositoryImpl.deleteRuc(companyId);
      if (response == null) {
        CustomSnackbar.showSnackBarCustom(
          context,
          title: 'Error',
          message:
              'Ocurrio un error al tratar actualizar su ruc. Por favor intente nuevamente',
          type: 2,
          time: 2,
        );
        return;
      }
      print('borrando compania');
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Éxito',
        message: 'Compania eliminado con éxito',
        type: 3,
        time: 2,
      );
      listCompanies.removeWhere((company) => company.id == companyId);
    } catch (e) {
        CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: messageErrorBadRequest,
        type: 2,
        time: 2,
      );
    } finally {
      isDeletingRuc = false;
      notifyListeners();
    }
  }

  void onEdit(String companyId) {
    final company = listCompanies
        .firstWhere((c) => c.id == companyId // 👈 depende si manejas nulos o no
            );
    companyIdToEdit = companyId;
    ctrlRuc.text = company.ruc ?? '';
    ctrlCompanyName.text = company.businessName ?? '';
    ctrlAddress.text = company.address ?? '';
    ctrlEmail.text = company.email ?? '';
    ctrlPhoneNumber.text = company.phone ?? '';
  }

  void onCreate() {
    ctrlRuc.text = '';
    ctrlCompanyName.text = '';
    ctrlAddress.text = '';
    ctrlEmail.text = '';
    ctrlPhoneNumber.text = '';
  }

  String? _selectedCompanyId;
  String? get selectedCompanyId => _selectedCompanyId;

  void selectCompany(String id) {
    _selectedCompanyId = id;
    notifyListeners();
  }
  // Métodos para manejar la lógica de negocio, como validaciones o envíos de datos.
}
