import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';

abstract class InvoiceRepository {
  Future<List<Company>> getRucs(String personId);
  Future<Company?> createRuc(CompanyModel newCompany);
  Future<Company?> updateRuc(CompanyModel companyUpdate);
}

