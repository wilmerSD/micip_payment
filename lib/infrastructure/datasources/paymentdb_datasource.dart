import 'package:cip_payment_web/core/config/environment.dart';
import 'package:cip_payment_web/domain/datasources/payment_datasource.dart';
import 'package:cip_payment_web/domain/entities/culqipayment.dart';
import 'package:cip_payment_web/domain/entities/culqipayment_mapper.dart';
import 'package:cip_payment_web/domain/entities/payment.dart';
import 'package:cip_payment_web/domain/entities/quota.dart';
import 'package:cip_payment_web/domain/entities/token.dart';
import 'package:cip_payment_web/infrastructure/mappers/payment_mapper.dart';
import 'package:cip_payment_web/infrastructure/mappers/quota_mapper.dart';
import 'package:cip_payment_web/infrastructure/mappers/token_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/culqi/culqi_payment_response.dart';
import 'package:cip_payment_web/infrastructure/models/culqi/culqi_token_response.dart';
import 'package:cip_payment_web/infrastructure/models/quota_model.dart';
import 'package:cip_payment_web/infrastructure/models/response/payment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentdbDatasource extends PaymentDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;
  // final String linkBack = 'http://192.168.100.92:8080';
  final String linkBack = 'https://cip-payment-culqi.onrender.com';
  @override
  Future<Token?> createTokenCulqi({
    required String cardNumber,
    required String cvv,
    required String expirationMonth,
    required String expirationYear,
    required String email,
  }) async {
    // try{
    //TODO envolver con try catch para ver el posible error
    final url = Uri.parse("https://api.culqi.com/v2/tokens");
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json", // importante
      "Authorization":
          "Bearer ${Environment.publicKeyCulqi}", // Reemplaza con tu llave pública real
    };

    final body = {
      "card_number": cardNumber,
      "cvv": cvv,
      "expiration_month": expirationMonth,
      "expiration_year": expirationYear,
      "email": email,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final tokenResponse = CulqiTokenResponse.fromJson(data);
      final token = TokenMapper.tokenResponseToEntity(tokenResponse);
      return token;
    } else {
      debugPrint("Error creando token: ${response.body}");
      return null;
    }
    // }catch(e){
    //   Tro
    // }
  }

  @override
  Future<Culqipayment?> payCulqi(String token, int amount, String email) async {
    //TODO envolver con try catch para ver el posible error
    print("Intentando pago desde paymentdb_datasource");
    final response = await http.post(
      Uri.parse("$linkBack/pago"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "token": token,
        "amount": amount, // S/10.00
        "email": email, //"usuario@example.com",
      }),
    );
    final data = jsonDecode(response.body);
    final paymentResponse = CulqiPaymentResponse.fromJson(data);
    final payment = CulqiPaymentMapper.paymentResponseToEntity(paymentResponse);
    return payment;
  }

  @override
  Future<List<Quota>?> payQuotas(List<PaymentModel> quotasToPay) async {
    try {
      final List<Quota> paidQuotas = [];

      for (final quotaModel in quotasToPay) {
        final response = await FirebaseFirestore.instance
            .collection('Payment')
            .add(quotaModel.toJson());

        if (response.id.isNotEmpty) {
          await response.update({'id': response.id});
          final snapshot = await response.get();
          final data = snapshot.data() as Map<String, dynamic>;
          print(data);
          final quotaResponse = QuotaModel.fromFirestore(data);
          final quota = QuotaMapper.quotaResponseToEntity(quotaResponse);

          paidQuotas.add(quota);
        }
      }
      debugPrint('✅ ${paidQuotas[0].id} cuotas pagadas exitosamente');
      return paidQuotas;
    } catch (e) {
      debugPrint('❌ Error al crear pagos: $e');
      return null;
    }
  }

  @override
  Future<Payment?> payment(PaymentModel payment) async {
    try {
      final docRef = await FirebaseFirestore.instance
          .collection('Payment')
          .add(payment.toJson());

      // Agregamos el id al documento
      await docRef.update({'id': docRef.id});

      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>;

      final paymentResponse = PaymentModel.fromJson(data);
      final paymentEntity =
          PaymentMapper.storepayResponseToEntity(paymentResponse);

      debugPrint('✅ Pago registrado correctamente con ID: ${docRef.id}');
      return paymentEntity;
    } catch (e) {
      debugPrint('❌ Error al crear pago: $e');
      return null;
    }
  }

  @override
  Future<bool> paymentDetail(List<QuotaModel> quotasToPay, String paymentId,
      int typePay, /* List<PaymentdetailModel>? paymentDetail */) async {
    try {
      final List<Quota> paidQuotas = [];
      /* if (paymentDetail != null) {
        for (final paymentDet in paymentDetail) {
         final docRef = await FirebaseFirestore.instance
              .collection('PaymentDetail')
              .add(paymentDet.toJson());

          await docRef.update({'id': docRef.id});
          final quotaResponse = QuotaModel.fromFirestore(docRef.);
          paidQuotas.add(QuotaMapper.quotaResponseToEntity(paymentDet));
        }
      }else{ */
        for (final quota in quotasToPay) {
          final paymentFeeData = {
            'paymentId': paymentId,
            'referenceId': quota.id,
            'amountPaid': quota.amount, // o el monto exacto pagado
            'createdAt': FieldValue.serverTimestamp(),
            'referenceType': typePay,
          };

          final docRef = await FirebaseFirestore.instance
              .collection('PaymentDetail')
              .add(paymentFeeData);

          await docRef.update({'id': docRef.id});

          paidQuotas.add(QuotaMapper.quotaResponseToEntity(quota));
        }
  /*     } */

      debugPrint(
          '✅ ${paidQuotas.length} cuotas registradas correctamente en PaymentFee');
      return true;
    } catch (e) {
      debugPrint('❌ Error al registrar PaymentFee: $e');
      return false;
    }
  }

  @override
  Future<List<Quota>> getPaymentFeesByPaymentId(String paymentId) async {
    try {
      final query = await firestoredb
          .collection('PaymentDetail')
          .where('paymentId', isEqualTo: paymentId)
          .get();

      final List<Quota> quotas = [];
      for (final doc in query.docs) {
        final data = doc.data();
        final quotaId = data['referenceId'];

        if (quotaId != null) {
          // 🔹 Buscar la cuota real en la colección "Quota"
          final quotaSnapshot =
              await firestoredb.collection('MemberFee').doc(quotaId).get();

          if (quotaSnapshot.exists) {
            final quotaData = quotaSnapshot.data() as Map<String, dynamic>;
            final quotaModel = QuotaModel.fromFirestore(quotaData);

            final quota = QuotaMapper.quotaResponseToEntity(quotaModel);
            quotas.add(quota);
          }
        }
      }
      debugPrint('✅ ${quotas.length} cuotas obtenidas para el pago $paymentId');
      return quotas;
      // return query.docs.map((doc) {
      //   final data = doc.data();
      //   final quotaModel = QuotaModel.fromFirestore(data);
      //   return QuotaMapper.quotaResponseToEntity(quotaModel);
      // }).toList();
    } catch (e) {
      debugPrint('❌ Error al obtener cuotas del pago: $e');
      return [];
    }
  }

  @override
  Future<List<Payment>?> historyPaymentQuotas(
      String personId, int typePay) async {
    try {
      final snapshot = await firestoredb
          .collection('Payment')
          .where('personId', isEqualTo: personId)
          .where('typePay', isEqualTo: typePay)
          .get();

      final paymentQuotaResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return PaymentModel.fromJson(data);
      }).toList();
      // print(paymentQuotaResponse);
      final paymentQuotas = paymentQuotaResponse
          .map((resp) => PaymentMapper.storepayResponseToEntity(resp))
          .toList();
      return paymentQuotas;
    } catch (e) {
      debugPrint("Error al obtener las cuotas pendientes de la persona : $e");
      return [];
    }
  }
}
