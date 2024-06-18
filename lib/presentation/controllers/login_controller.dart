import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var emailError = ''.obs;

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

    final String url = 'http://10.0.2.2:3001/api/v1/user/login'; // Usar la dirección IP local correcta

    try {
      var headers = {
        'Content-Type': 'application/json'
      };

      var body = jsonEncode({
        'email': email,
        'password': password
      });

      print("Enviando solicitud a $url con body: $body y headers: $headers");

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print("Código de respuesta: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Login exitoso: $data");
        Get.toNamed('/home'); // Redirigir a la página principal o a la página de inicio
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error['message'],
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
