import 'package:cip_payment_web/domain/datasources/invoice_datasource.dart';
import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/domain/repositories/invoice_repository.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  final InvoiceDatasource datasource;
  InvoiceRepositoryImpl(this.datasource);

  @override
  Future<Company?> createRuc(CompanyModel newCompany) {
    return datasource.createRuc(newCompany);
  }

  @override
  Future<List<Company>> getRucs(String personId) {
    return datasource.getRucs(personId);
  }

  @override
  Future<Company?> updateRuc(CompanyModel companyUpdate) {
    return datasource.updateRuc(companyUpdate);
  }
}
