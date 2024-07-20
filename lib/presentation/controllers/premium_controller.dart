import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PremiumController extends GetxController {
  var plans = [].obs;
  var isLoading = true.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    fetchPlans();
    super.onInit();
  }

  void fetchPlans() async {
    final url = 'https://payment-service-wdzc.onrender.com/api/v1/subscriptions_plans/';
    final headers = {
      'X-API-Key': 'your_api_key_here', // Reemplaza con tu API key si es necesario
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData is List) {
          plans.value = responseData;
        } else if (responseData is Map<String, dynamic> && responseData.containsKey('plans')) {
          plans.value = responseData['plans'];
        } else {
          Get.snackbar('Error', 'Formato de respuesta inesperado.');
        }
      } else {
        Get.snackbar('Error', 'Error al obtener los planes: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error en la solicitud: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> subscribeToPlan(int planId) async {
    final userId = storage.read('user')['id'];
    final url = 'https://payment-service-wdzc.onrender.com/api/v2/subscriptions/';
    final headers = {
      'Content-Type': 'application/json',
      'X-API-Key': 'your_api_key_here',
    };

    final body = jsonEncode({
      'user_id': userId,
      'plan_id': planId,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final subscriptionResponse = json.decode(response.body);
        final subscriptionId = subscriptionResponse['createdSubscription']['subscription_id'];
        await fetchTransactionApprovalUrl(subscriptionId);
      } else {
        Get.snackbar('Error', 'Error al suscribirse al plan: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error en la solicitud de suscripción: $e');
    }
  }

  Future<void> fetchTransactionApprovalUrl(int subscriptionId) async {
    final userId = storage.read('user')['id'];
    final url = 'https://payment-service-wdzc.onrender.com/api/v3/transactions/$userId';
    final headers = {
      'X-API-Key': 'your_api_key_here',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final transactionResponse = json.decode(response.body);
        final approvalUrl = transactionResponse['approval_url'];
        if (await canLaunch(approvalUrl)) {
          await launch(approvalUrl);
        } else {
          Get.snackbar('Error', 'No se puede abrir el enlace de aprobación');
        }
      } else {
        Get.snackbar('Error', 'Error al obtener la transacción: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error en la solicitud de transacción: $e');
    }
  }
}
