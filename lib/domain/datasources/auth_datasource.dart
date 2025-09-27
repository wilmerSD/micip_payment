import 'package:cip_payment_web/domain/entities/user.dart';

abstract class AuthDatasource {
  Future<User?> loginUser(String email, String password);
  
}