
import 'package:cip_payment_web/domain/entities/log.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';

class LogMapper {
  static Log courseResponseToEntity(LogtimeModel log) =>
  Log(
    cip: log.cip ?? '',
    dni: log.dni ?? '',
    fullNames: log.fullNames ?? '',
    id: log.id ?? '',
    paymentDateEnd: log.paymentDateEnd,
    paymentDateStart: log.paymentDateStart,
    paymentId: log.paymentId ?? '',
    typePay: log.typePay ?? 0,
    typePayName: log.typePayName ?? '',
  );
}