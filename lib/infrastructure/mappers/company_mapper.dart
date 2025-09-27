import 'package:cip_payment_web/domain/entities/company.dart';
import 'package:cip_payment_web/infrastructure/models/company_model.dart';

class CompanyMapper {
  static Company companyResponseToEntity(CompanyModel company) =>
  Company(
    address: company.address ?? '',
    businessName: company.businessName ?? '',
    createdAt: company.createdAt ,
    email: company.email ?? '',
    personId: company.personId ?? '',
    phone: company.phone,
    ruc: company.ruc ?? '',
    status: company.status ?? false,
    tradeName: company.tradeName ?? '',
    updatedAt: company.updatedAt,
  );
}