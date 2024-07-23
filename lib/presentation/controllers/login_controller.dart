import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../controllers/navigation_controller.dart';
import 'dart:convert';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var emailError = ''.obs;
  final storage = GetStorage();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = '';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = "Ingrese un correo electrónico válido";
    } else {
      emailError.value = '';
    }
  }

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Por favor complete todos los campos',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final String url = 'https://app.cristilex.com/api/v1/user/login';

    try {
      var headers = {
        'Content-Type': 'application/json'
      };

      var body = jsonEncode({
        'email': email,
        'password': password
      });

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("Login exitoso: $data");

        // Guardar datos en GetStorage
        storage.write('user', {
          'id': data['id'],
          'token': data['token'],
          'name': data['name'],
          'email': data['email'],
          'phone_number': data['phone_number'],
          'suscription': data['suscription'],
          'verification': data['verification'],
          'image': data['image']
        });

        // Restablecer el índice del controlador de navegación
        final NavigationController navigationController = Get.find<NavigationController>();
        navigationController.resetIndex();
        Get.offAllNamed('/home'); // Navegar a la página de inicio
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error['message'] ?? 'Error desconocido',
            snackPosition: SnackPosition.BOTTOM);
        print("Error al iniciar sesión: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error en la solicitud de inicio de sesión: $e");
      Get.snackbar('Error', 'No se pudo conectar con el servidor',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
