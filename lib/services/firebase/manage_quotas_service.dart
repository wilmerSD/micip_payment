import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageQuotasService {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  Future<List<QuotaModel>> fetchAllQuotas() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('MemberFee')
          .get();
      final quotas = snapshot.docs.map((doc) {
        final data = doc.data();
        return QuotaModel.fromFirestore(data);
      }).toList();

      return quotas;
    } catch (e) {
      print('Error al obtener cuotas: $e');
      return [];
    }
  }

  Future<String> createQuota(QuotaModel course) async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('MemberFee')
          .add(course.toFirestore());
      debugPrint('✅ Curso creada exitosamente');
      if (response.id.isNotEmpty) {
        return response.id;
      }
      return '';
    } catch (e) {
      debugPrint('❌ Error al crear persona: $e');
      return '';
    }
  }

  Future<void> generateQuotasForEligiblePersons({
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

      print("Encontradas ${personsSnap.docs.length} personas elegibles");

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
            "fullNamePerson": personData["namePerson"]+' '+personData["paternalSurname"]+personData["motherSurname"],
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
        print("✅ Commit final de ${counter % 500} cuotas");
      }

      print("🎉 Cuotas generadas: $counter en total");
    } catch (e) {
      print("❌ Error al generar cuotas: $e");
    }
  }

}
