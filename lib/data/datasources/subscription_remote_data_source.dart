import 'dart:convert';
import 'package:http/http.dart' as http;

class SubscriptionRemoteDataSource {
  final http.Client client;

  SubscriptionRemoteDataSource(this.client);

  Future<Map<String, dynamic>> fetchTransactions(int userId) async {
    final response = await client.get(Uri.parse('https://payment-service-wdzc.onrender.com/api/v3/transactions/$userId'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<Map<String, dynamic>> fetchPlans(String token) async {
    final headers = {'X-API-Key': token};
    final response = await client.get(Uri.parse('https://payment-service-wdzc.onrender.com/api/v1/subscriptions_plans/'), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load plans');
    }
  }

  Future<Map<String, dynamic>> subscribeToPlan(int userId, int planId) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-API-Key': 'your_api_key_here'
    };
    final response = await client.post(
      Uri.parse('https://payment-service-wdzc.onrender.com/api/v2/subscriptions/'),
      body: json.encode({'user_id': userId, 'plan_id': planId}),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to subscribe to plan');
    }
  }

  Future<Map<String, dynamic>?> fetchSubscription(int userId, String token) async {
    final headers = {'X-API-Key': token};
    final response = await client.get(
      Uri.parse('https://payment-service-wdzc.onrender.com/api/v2/subscriptions/$userId'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }


}
