import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';

class QuotaMapper {
  static Quota quotaResponseToEntity(QuotaModel quotadb) => Quota(
    id: quotadb.id ?? '',
    isSelected: quotadb.isSelected,
    personId: quotadb.personId ?? '',
    namePerson: quotadb.namePerson ?? '',
    motherSurname: quotadb.motherSurname ?? '',
    paternalSurname: quotadb.paternalSurname ?? '',
    dni: quotadb.dni ?? '',
    amount: quotadb.amount ?? 0,
    feeYear: quotadb.feeYear ?? 0,
    feeMonth: quotadb.feeMonth ?? 0,
    status: quotadb.status ?? '',
    createdAt: quotadb.createdAt,
    updatedAt: quotadb.updatedAt,
    dueDate: quotadb.dueDate,
    fullNamePerson: quotadb.fullNamePerson,
  );
}
