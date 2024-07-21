import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/pages/webview_page.dart'; // Add this line

class PremiumController extends GetxController {
  var plans = [].obs;
  var isLoading = true.obs;

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
        if (responseData is Map<String, dynamic> && responseData.containsKey('plans')) {
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

  void subscribeToPlan(int planId) async {
    final storage = GetStorage();
    final user = storage.read('user');
    final userId = user['id']; // Asegúrate de que el user_id no sea null

    if (userId == null) {
      Get.snackbar('Error', 'No se encontró el ID de usuario.');
      return;
    }

    final url = 'https://payment-service-wdzc.onrender.com/api/v2/subscriptions/';
    final headers = {
      'Content-Type': 'application/json',
      'X-API-Key': 'your_api_key_here', // Reemplaza con tu API key si es necesario
    };
    final body = json.encode({
      'user_id': userId,
      'plan_id': planId,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['createdSubscription'] != null) {
          final approvalUrl = data['createdSubscription']['transaction']['approval_url'];
          Get.to(() => WebViewPage(url: approvalUrl));
        } else {
          Get.snackbar('Error', 'Formato de respuesta inesperado.');
        }
      } else {
        Get.snackbar('Error', 'Error al crear la suscripción: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error en la solicitud de suscripción: $e');
    }
  }
}
