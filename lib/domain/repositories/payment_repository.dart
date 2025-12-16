import 'package:cip_payment_web/domain/entities/culqipayment.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';

abstract class PaymentRepository {
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  });
  Future<Culqipayment?>  payCulqi(String token, int amount, String email);
  Future<List<Quota>?> payQuotas(List<PaymentModel> paymentQuotaModel);
  Future<Payment?> payment(PaymentModel payment);
  Future<bool> paymentDetail(List<QuotaModel> quotasToPay, String paymentId, int typePay);
  Future<List<Payment>?> historyPaymentQuotas(String personId, int typePay);
  Future<List<Quota>> getPaymentFeesByPaymentId(String paymentId);
}