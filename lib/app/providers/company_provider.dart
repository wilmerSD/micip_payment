import 'package:cip_payment_web/core/preferences/shared_preferences.dart';
import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/datasources/invoice_datasource.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';
import 'package:cip_payment_web/infrastructure/repositories/invoice_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CompanyProvider with ChangeNotifier {
  final InvoiceRepositoryImpl invoiceRepositoryImpl = InvoiceRepositoryImpl(
    InvoicedbDatasource(),
  );

  String personId = '';
  String mainEmail = '';
  List<Company> listCompanies = [];
  Company company = Company();

  Future<void> onInit() async {
    await getDataPerson();
    getRucs();
  }

  Future<void> getDataPerson() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
  }

  Future<void> createRuc(CompanyModel newCompany) async {
    try {
      final response = await invoiceRepositoryImpl.createRuc(CompanyModel());
      company = response ?? Company();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getRucs() async {
    listCompanies.clear();
    try {
      final response = await invoiceRepositoryImpl.getRucs(personId);
      listCompanies.addAll(response);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateRuc(CompanyModel companyUpdate) async {
    try {
      final response = await invoiceRepositoryImpl.createRuc(CompanyModel());
      company = response ?? Company();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
