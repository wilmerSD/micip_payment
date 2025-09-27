import 'package:cip_payment_web/domain/datasources/auth_datasource.dart';
import 'package:cip_payment_web/domain/entities/user.dart';
import 'package:cip_payment_web/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDatasource datasource;
  AuthRepositoryImpl(this.datasource);
  
  @override
  Future<User?> loginUser({required String email,required String password}) {
    return datasource.loginUser(email, password);
  }

}