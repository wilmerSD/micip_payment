import 'package:cip_payment_web/domain/entities/log.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';

abstract class LogRepository {
  Future<Log?> createLog(LogtimeModel log);
  
}


