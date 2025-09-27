import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/infrastructure/models/culqi/culqi_payment_response.dart';

class PaymentMapper {
  static Payment? paymentResponseToEntity(CulqiPaymentResponse paymentdb) {
    if (paymentdb.isSuccess) {
      final success = paymentdb.success!;
      return Payment(
        succces: true,
        object: success.object ?? '',
        id: success.id ?? '',
        creationDate: success.creationDate ?? 0,
        amount: success.amount ?? 0,
        amountRefunded: success.amountRefunded ?? 0,
        currentAmount: success.currentAmount ?? 0,
      );
    }
     if (paymentdb.isError) {
      final error = paymentdb.error!;
      // Puedes manejarlo de dos formas:
      // 1. Devolver null
      // 2. Lanzar excepción con el mensaje de error
      // throw Exception(
      //   "Culqi error: ${error.userMessage ?? error.merchantMessage}",
      // );
      return Payment(
        succces: false,
        object: error.object ?? '',
        userMessage: error.userMessage ?? '',
        merchantMessage: error.merchantMessage ?? ''
      );
    }
    return null;
  }
}
