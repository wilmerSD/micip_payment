import 'dart:async';

import 'package:cip_payment_web/domain/datasources/quota_datasource.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/repositories/quota_repository.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';

class QuotaRepositoryImpl extends QuotaRepository {
  final QuotaDatasource datasource;
  QuotaRepositoryImpl(this.datasource);

  @override
  Future<Quota?> createQuota(QuotaModel course) {
    return datasource.createQuota(course);
  }

  @override
  Future<List<Quota>> fetchAllQuotas() {
    return datasource.fetchAllQuotas();
  }

  @override
  Future<List<Quota>> fetchQuotasByPerson(String personId) {
    return datasource.fetchQuotasByPerson(personId);
  }

  @override
  Future<bool> generateQuotasForEligiblePersons({
    required int feeMonth,
    required int feeYear,
    required double amount,
  }) {
    return datasource.generateQuotasForEligiblePersons(
      feeMonth: feeMonth,
      feeYear: feeYear,
      amount: amount,
    );
  }

  @override
  Future<bool> hasPendingQuotas(String personId) {
    return datasource.hasPendingQuotas(personId);
  }

  @override
  Future<List<Quota>> historyPaymentQuotas(String personId) {
    return datasource.historyPaymentQuotas(personId);
  }
  @override
  Future<List<Quota>> updateQuotas(List<QuotaModel> quotasToPay) {
    return datasource.updateQuotas(quotasToPay);
  }
}
