import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';

abstract class QuotaRepository {
  Future<List<Quota>> fetchAllQuotas(); // Para el admin
  Future<List<Quota>> fetchQuotasByPerson(String personId); // Para un usuario
  Future<Quota?> createQuota(QuotaModel course);
  Future<bool> generateQuotasForEligiblePersons({
    required int feeMonth,
    required int feeYear,
    required double amount,
  });
  Future<bool> hasPendingQuotas(String personId);
  Future<List<Quota>> historyPaymentQuotas(String personId);
  Future<List<Quota>> updateQuotas(List<QuotaModel> quotasToPay);
}
