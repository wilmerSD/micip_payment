import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyfeesService {
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


}
