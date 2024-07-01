import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:get_storage/get_storage.dart';

import 'home_controller.dart';

class AddCowController extends GetxController {
  var imagePath = ''.obs;
  var nameController = TextEditingController();
  var weightController = TextEditingController();
  var earringNumberController = TextEditingController();
  var ageController = TextEditingController();
  var gender = ''.obs;
  var breed = ''.obs;

  void pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  Future<void> addCow() async {
    final storage = GetStorage();
    final userId = storage.read('user')['id'];
    final url = Uri.parse('https://bovisales-backend.onrender.com/api/v1/Cattle/');

    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'name': nameController.text,
      'weight': weightController.text,
      'earringNumber': earringNumberController.text,
      'age': ageController.text,
      'gender': gender.value,
      'breed': breed.value,
      'id_user': userId.toString(),
    });

    if (imagePath.value.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath.value));
    }

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print("Cow added successfully.");
        print(responseData); // Imprime la respuesta del servidor
        Get.offNamed('/home'); //
        Get.find<HomeController>().fetchBovinos();
        // Navegar a la página de inicio
      } else {
        print('Error al agregar el bovino: ${response.reasonPhrase}');
        print(responseData); // Imprime la respuesta del servidor en caso de error
      }
    } catch (e) {
      print('Error en la solicitud de agregar bovino: $e');
    }
  }
}
