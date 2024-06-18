import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignupController extends GetxController {
  var imagePath = ''.obs;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
  var isEmailValid = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void validateEmail(String email) {
    if (email.isEmpty || GetUtils.isEmail(email)) {
      isEmailValid.value = true;
    } else {
      isEmailValid.value = false;
    }
  }

  bool validateInputs() {
    if (!GetUtils.isEmail(emailController.text)) {
      isEmailValid.value = false;
      return false;
    }
    return true;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  Future<void> createUser() async {
    if (validateInputs()) {
      isLoading.value = true;
      try {
        var url = Uri.parse('http://10.0.2.2:3001/api/v1/user/'); // Dirección de tu backend
        var body = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phone_number': phoneNumberController.text,
        };

        if (imagePath.value.isNotEmpty) {
          body['image'] = imagePath.value;
        } else {
          body['image'] = "aaaaada"; // Asegúrate de que este campo se ajuste a las expectativas de tu backend
        }

        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 201) {
          var responseData = jsonDecode(response.body);
          print('Usuario creado: $responseData');
          // Redirigir a la página de inicio de sesión después de la creación exitosa del usuario
          Get.toNamed('/login');
        } else {
          print('Error al crear el usuario: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error al crear el usuario: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
