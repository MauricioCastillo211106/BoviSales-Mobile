import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'navigation_controller.dart';

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
        var request = http.MultipartRequest('POST', Uri.parse('https://bovisales-backend.onrender.com/api/v1/user/'));
        request.fields['name'] = nameController.text;
        request.fields['email'] = emailController.text;
        request.fields['password'] = passwordController.text;
        request.fields['phone_number'] = phoneNumberController.text;

        if (imagePath.value.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath('image', imagePath.value));
        } else {
          request.fields['image'] = ''; // Ajusta este campo según las expectativas de tu backend
        }

        var response = await request.send();

        if (response.statusCode == 201) {
          var responseData = await http.Response.fromStream(response);
          print('Usuario creado: ${responseData.body}');
          // Redirigir a la página de inicio de sesión después de la creación exitosa del usuario
          final NavigationController navigationController = Get.find<NavigationController>();
          navigationController.resetIndex();
          Get.toNamed('/login');
        } else {
          print('Error al crear el usuario: ${response.statusCode}');
          var responseData = await http.Response.fromStream(response);
          print('Response body: ${responseData.body}');
        }
      } catch (e) {
        print('Error al crear el usuario: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
