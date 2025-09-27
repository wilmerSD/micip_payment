import 'package:cip_payment_web/infrastructure/models/culqi/culqi_error_response.dart';
import 'package:cip_payment_web/infrastructure/models/culqi/culqi_token_success_response.dart';

class CulqiTokenResponse {
  final CulqiTokenSuccessResponse? success;
  final CulqiErrorResponse? error;

  CulqiTokenResponse({this.success, this.error});

  factory CulqiTokenResponse.fromJson(Map<String, dynamic> json) {
    if (json['object'] == 'error') {
      return CulqiTokenResponse(error: CulqiErrorResponse.fromJson(json));
    } else {
      return CulqiTokenResponse(success: CulqiTokenSuccessResponse.fromJson(json));
    }
  }

  bool get isSuccess => success != null;
  bool get isError => error != null;
}
