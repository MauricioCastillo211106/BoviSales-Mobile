import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileController extends GetxController {
  var isSubscribed = false.obs;
  var transactionStatus = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    var user = GetStorage().read('user') ?? {};
    if (user['suscription'] == 1) {
      isSubscribed.value = true;
      fetchTransactionStatus(user['id']);
    } else {
      isSubscribed.value = false;
      isLoading.value = false;
    }
  }

  void fetchTransactionStatus(int userId) async {
    final url = 'https://payment-service-wdzc.onrender.com/api/v3/transactions/$userId';
    final headers = {
      'X-API-Key': 'your_api_key_here',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> && responseData.containsKey('status')) {
          transactionStatus.value = responseData['status'];
        } else {
          Get.snackbar('Error', 'Formato de respuesta inesperado.');
        }
      } else {
        Get.snackbar('Error', 'Error al obtener el estado de la transacción: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error en la solicitud: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logOut() {
    // Logic to log out
    GetStorage().erase(); // Delete user data
    Get.offAllNamed('/'); // Redirect to login
  }
}
