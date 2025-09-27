import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_quota_model.dart';

abstract class PaymentRepository {
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  });
  Future<Payment?>  payCulqi(String token, int amount, String email);
  Future<List<Quota>?> payQuotas(List<PaymentQuotaModel> paymentQuotaModel);
}