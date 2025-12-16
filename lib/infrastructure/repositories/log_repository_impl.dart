
import 'package:cip_payment_web/domain/datasources/log_datasource.dart';
import 'package:cip_payment_web/domain/entities/log.dart';
import 'package:cip_payment_web/domain/repositories/log_repository.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';

class LogRepositoryImpl extends LogRepository{
  final LogDatasource datasource;
  LogRepositoryImpl(this.datasource);

  @override
  Future<Log?> createLog(LogtimeModel log) {
    return datasource.createLog(log);
  }
  
}