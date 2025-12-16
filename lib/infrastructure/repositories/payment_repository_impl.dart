import 'package:cip_payment_web/domain/datasources/payment_datasource.dart';
import 'package:cip_payment_web/domain/entities/culqipayment.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
import 'package:cip_payment_web/domain/repositories/payment_repository.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDatasource datasource;

  PaymentRepositoryImpl(this.datasource);

  @override
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  }) {
    return datasource.createTokenCulqi(
      cardNumber: cardNumber,
      cvv: cvv,
      expirationMonth: expirationMonth,
      expirationYear: expirationYear,
      email: email,
    );
  }

  @override
  Future<Culqipayment?> payCulqi(String token, int amount, String email) {
    return datasource.payCulqi(token, amount, email);
  }

  @override
  Future<List<Quota>?> payQuotas(List<PaymentModel> paymentQuotaModel) {
    return datasource.payQuotas(paymentQuotaModel);
  }

  @override
  Future<Payment?> payment(PaymentModel payment) {
    return datasource.payment(payment);
  }

  @override
  Future<bool> paymentDetail(
      List<QuotaModel> quotasToPay, String paymentId, int typePay) {
    return datasource.paymentDetail(quotasToPay, paymentId, typePay);
  }

  @override
  Future<List<Payment>?> historyPaymentQuotas(String personId, int typePay) {
    return datasource.historyPaymentQuotas(personId, typePay);
  }

  @override
  Future<List<Quota>> getPaymentFeesByPaymentId(String paymentId) {
    return datasource.getPaymentFeesByPaymentId(paymentId);
  }

  // @override
  // Future<List<Storepay>?> historyPaymentQuotas(String personId) {
  //   return datasource.historyPaymentQuotas(personId);
  // }
}
