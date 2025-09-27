import 'package:cip_payment_web/domain/datasources/quota_datasource.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/infrastructure/mappers/quota_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuotadbDatasource extends QuotaDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<Quota?> createQuota(QuotaModel course) async {
    try {
      final response = await firestoredb
          .collection('MemberFee')
          .add(course.toFirestore());
      debugPrint('✅ Curso creada exitosamente');
      if (response.id.isNotEmpty) {
        // 2. Obtener datos recién guardados
        final snapshot = await response.get();
        final data = snapshot.data() as Map<String, dynamic>;
        // 3. Mapear a Response
        final quotaResponse = QuotaModel.fromFirestore(data);
        // 4. Mapear a Entidad
        final quota = QuotaMapper.quotaResponseToEntity(quotaResponse);
        return quota;
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error al crear persona: $e');
      return null;
    }
  }

  @override
  Future<List<Quota>> fetchQuotasByPerson(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('MemberFee')
          .where('personId', isEqualTo: personId)
          .where('status', isEqualTo: 'pending')
          .get();

      final quotasResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return QuotaModel.fromFirestore(data);
      }).toList();
      final quotas = quotasResponse
          .map((resp) => QuotaMapper.quotaResponseToEntity(resp))
          .toList();

      return quotas;
    } catch (e) {
      debugPrint("Error al obtener las cuotas pendientes de la persona : $e");
      return [];
    }
  }

  @override
  Future<List<Quota>> updateQuotas(List<QuotaModel> quotasToPay) async {
    try {
      final List<Quota> updatedQuotas = [];

      for (final quotaModel in quotasToPay) {
        if (quotaModel.id == null || quotaModel.id!.isEmpty) {
          debugPrint("⚠️ La cuota no tiene un ID válido, se omite.");
          continue;
        }

        // Actualizamos el documento existente en Firestore
        await firestoredb.collection('MemberFee').doc(quotaModel.id).update({
          ...quotaModel.toFirestore(),
          "status": "completed", // Aquí forzamos el cambio de estado
        });

        // Obtenemos el documento actualizado
        final snapshot = await firestoredb
            .collection('MemberFee')
            .doc(quotaModel.id)
            .get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final quotaResponse = QuotaModel.fromFirestore(data);
          final quota = QuotaMapper.quotaResponseToEntity(quotaResponse);

          updatedQuotas.add(quota);
        }
      }

      return updatedQuotas;
    } catch (e, stack) {
      debugPrint("❌ Error al actualizar las cuotas: $e");
      debugPrint("StackTrace: $stack");
      return [];
    }
  }

  @override
  Future<bool> generateQuotasForEligiblePersons({
    required int feeMonth,
    required int feeYear,
    required double amount,
  }) async {
    try {
      // 1. Traer solo las personas activas y no admin
      final personsSnap = await firestoredb
          .collection("Person")
          .where("statePerson", isEqualTo: true)
          .where("isAdmin", isEqualTo: false)
          .get();

      debugPrint("Encontradas ${personsSnap.docs.length} personas elegibles");

      int counter = 0;
      WriteBatch batch = firestoredb.batch();

      for (var personDoc in personsSnap.docs) {
        final personData = personDoc.data();
        final personId = personDoc.id;

        // 2. Verificar si ya existe una cuota para esa persona en ese mes/año
        final existingQuota = await firestoredb
            .collection("MemberFee")
            .where("personMonthYear", isEqualTo: "$personId-$feeMonth-$feeYear")
            .limit(1)
            .get();

        if (existingQuota.docs.isEmpty) {
          // 3. Si no existe, agregar al batch
          final quotaRef = firestoredb.collection("MemberFee").doc();

          batch.set(quotaRef, {
            "id": quotaRef.id,
            "personId": personId,
            "fullNamePerson":
                personData["namePerson"] +
                ' ' +
                personData["paternalSurname"] +
                personData["motherSurname"],
            "dni": personData["dni"],
            "namePerson": personData["namePerson"],
            "paternalSurname": personData["paternalSurname"],
            "motherSurname": personData["motherSurname"],
            "amount": amount,
            "feeMonth": feeMonth,
            "feeYear": feeYear,
            "status": "pending",
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp(),
            "dueDate": DateTime(feeYear, feeMonth, 28), // ejemplo
            "personMonthYear": "$personId-$feeMonth-$feeYear",
          });

          counter++;

          // 4. Commit cada 500 operaciones
          if (counter % 500 == 0) {
            await batch.commit();
            batch = firestoredb.batch();
            print("✅ Commit de $counter cuotas");
          }
        } else {
          print("⏩ Ya existe cuota para $personId ($feeMonth/$feeYear)");
        }
      }

      // 5. Commit final si hay sobrantes
      if (counter % 500 != 0) {
        await batch.commit();
        debugPrint("✅ Commit final de ${counter % 500} cuotas");
      }
      debugPrint("🎉 Cuotas generadas: $counter en total");
      return true;
    } catch (e) {
      debugPrint("❌ Error al generar cuotas: $e");
      return false;
    }
  }

  @override
  Future<bool> hasPendingQuotas(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('MemberFee')
          .where('personId', isEqualTo: personId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) return true;
      return false;
    } catch (e) {
      debugPrint("Error al obtener las cuotas pendientes de la persona : $e");
      return false;
    }
  }

  @override
  Future<List<Quota>> historyPaymentQuotas(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('PaymentsGenerated')
          .where('personId', isEqualTo: personId)
          .get();

      final quotasResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return QuotaModel.fromFirestore(data);
      }).toList();
      final quotas = quotasResponse
          .map((resp) => QuotaMapper.quotaResponseToEntity(resp))
          .toList();
      return quotas;
    } catch (e) {
      debugPrint("Error al obtener las cuotas pendientes de la persona : $e");
      return [];
    }
  }

  @override
  Future<List<Quota>> fetchAllQuotas() async {
    try {
      final snapshot = await firestoredb
          .collection('MemberFee')
          .get();
      final quotasResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return QuotaModel.fromFirestore(data);
      }).toList();
      final quotas = quotasResponse
          .map((resp) => QuotaMapper.quotaResponseToEntity(resp))
          .toList();
      return quotas;
    } catch (e) {
      print('Error al obtener cuotas: $e');
      return [];
    }
  } // Para el admin
}
