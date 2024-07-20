import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

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
    final storage = GetStorage();
    final user = storage.read('user') ?? {};
    final userId = user['id'];

    final String url = 'https://payment-service-wdzc.onrender.com/api/v2/subscriptions/';

    var headers = {
      'Content-Type': 'application/json',
      'X-API-Key': 'your_api_key_here' // Reemplaza con tu token real
    };

    var body = jsonEncode({
      'user_id': userId,
      'plan_id': planId
    });

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Suscripción exitosa: $responseData");

        // Actualiza el estado de suscripción en GetStorage
        user['suscription'] = 1;
        storage.write('user', user);

        Get.snackbar('Éxito', responseData['message'],
            snackPosition: SnackPosition.BOTTOM);
      } else {
        print("Error al suscribirse: ${response.reasonPhrase}");
        Get.snackbar('Error', 'No se pudo completar la suscripción',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print("Error en la solicitud de suscripción: $e");
      Get.snackbar('Error', 'No se pudo conectar con el servidor',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
