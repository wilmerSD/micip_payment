import 'package:cip_payment_web/app/models/paymentgenerated_model.dart';
import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuotasService {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

    Future<List<QuotaModel>> fetchAllQuotas(String id) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('MemberFee')
          .where('personId', isEqualTo: id)
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
  
  Future<bool> quotasPendint(String personId) async {
    try {
      final snapshot = await firestoredb
          .collection('MemberFee')
          .where('personId', isEqualTo: personId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) return true;
      return false;
    } catch (e) {
      print("Error al obtener las cuotas pendientes de la persona : $e");
      return false;
    }
  }

  Future<List<PaymentgeneratedModel>> historyPaymentQuotas(
    String personId,
  ) async {
    try {
      final snapshot = await firestoredb
          .collection('PaymentsGenerated')
          .where('personId', isEqualTo: personId)
          .get();

      final quotas = snapshot.docs.map((doc) {
        final data = doc.data();
        return PaymentgeneratedModel.fromJson(data);
      }).toList();
      return quotas;
    } catch (e) {
      print("Error al obtener las cuotas pendientes de la persona : $e");
      return [];
    }
  }
}
