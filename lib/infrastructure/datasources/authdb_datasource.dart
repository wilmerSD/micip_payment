import 'package:cip_payment_web/domain/datasources/auth_datasource.dart';
import 'package:cip_payment_web/domain/entities/user.dart';
import 'package:cip_payment_web/infrastructure/mappers/user_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/response/user_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthdbDatasource extends AuthDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;
  
  @override
  Future<User?> loginUser(String email, String password) async {
    try {
      final querySnapshot = await firestoredb
          .collection('User')
          .where('userName', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();

        // 1. Pasar a Response (modelo)
        final userResponse = UserResponse.fromJson(userData);

        // 2. Mapear a Entidad
        final user = UserMapper.userResponseToEntity(userResponse);

        return user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión: $e");
      return null;
    }
  }
}
