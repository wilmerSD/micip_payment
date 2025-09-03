import 'dart:convert';

import 'package:cip_payment_web/app/models/response/login_response.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl =
      'https://api.ciplambayeque.com/v1/services/'; 
  

  Future<LoginResponse> getLogin(String user, String password) async {
    final String function = 'iniciarsesion';
    final url = Uri.parse(
      '${baseUrl}colegiado.php?funcion=$function&dni=$user,&clave=$password',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  // Future<List<ResponseListOrder>> getOrderProcessing(String status) async {
  //   final url = Uri.parse(
  //     '$baseUrl?status=$status&order=asc&per_page=20&consumer_key=$consumerKey&consumer_secret=$consumerSecret',
  //   );

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     return data.map((json) => ResponseListOrder.fromJson(json)).toList();
  //     /* final data = jsonDecode(response.body);
  //   return (data as List)
  //       .map((json) => ResponseListOrder.fromJson(json))
  //       .toList(); */
  //   } else {
  //     throw Exception('Error: ${response.statusCode} - ${response.body}');
  //   }
  // }

  // Future<OrderResponse> getOrderProcessingv1(String status) async {
  //   final url = Uri.parse(
  //     '$baseUrl?status=$status&order=asc&per_page=20&consumer_key=$consumerKey&consumer_secret=$consumerSecret',
  //   );

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final total = int.tryParse(response.headers['x-wp-total'] ?? '0') ?? 0;
  //     final List<dynamic> data = jsonDecode(response.body);
  //     final orders =
  //         data.map((json) => ResponseListOrder.fromJson(json)).toList();

  //     return OrderResponse(orders: orders, total: total);
  //   } else {
  //     throw Exception('Error: ${response.statusCode} - ${response.body}');
  //   }
  // }

  // Future<ResponseListOrder> postUpdateOrder(int orderId, String status) async {
  //   final url = Uri.parse(
  //     '$baseUrl/$orderId?per_page=20&consumer_key=$consumerKey&consumer_secret=$consumerSecret',
  //   );

  //   final response = await http.post(url, body: {"status": status});

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return ResponseListOrder.fromJson(data);
  //   } else {
  //     throw Exception('Error: ${response.statusCode} - ${response.body}');
  //   }
  // }
}
