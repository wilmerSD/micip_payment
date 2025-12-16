import 'package:cip_payment_web/domain/datasources/log_datasource.dart';
import 'package:cip_payment_web/domain/entities/log.dart';
import 'package:cip_payment_web/infrastructure/mappers/log_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/logtime_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LogdbDatasource extends LogDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<Log?> createLog(LogtimeModel log) async {
    try {
      // 1. Crear documento en Firestore
      final docRef = await firestoredb.collection('LogTime').add(log.toJson());

      debugPrint('✅ Log creado exitosamente con ID: ${docRef.id}');

      // 2. Actualizar el documento para incluir el id generado
      await docRef.update({'id': docRef.id});

      // 3. Obtener los datos actualizados
      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>;

      // 4. Mapear a Response
      final logResponse = LogtimeModel.fromJson(data);

      // 5. Mapear a Entidad
      final newLog = LogMapper.courseResponseToEntity(logResponse);

      return newLog;
    } catch (e) {
      debugPrint('❌ Error al crear log: $e');
      return null;
    }
  }
}
