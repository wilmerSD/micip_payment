import 'package:cip_payment_web/infrastructure/models/culqi/culqi_error_response.dart';
import 'package:cip_payment_web/infrastructure/models/culqi/culqi_payment_success_response.dart';

class CulqiPaymentResponse {
  final CulqiPaymentSuccessResponse? success;
  final CulqiErrorResponse? error;

  CulqiPaymentResponse({this.success, this.error});

  factory CulqiPaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['object'] == 'error') {
      return CulqiPaymentResponse(error: CulqiErrorResponse.fromJson(json));
    } else {
      return CulqiPaymentResponse(success: CulqiPaymentSuccessResponse.fromJson(json));
    }
  }

  bool get isSuccess => success != null;
  bool get isError => error != null;
}
