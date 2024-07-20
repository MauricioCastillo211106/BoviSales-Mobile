import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddCowController extends GetxController {
  var imagePath = ''.obs;
  var nameController = TextEditingController();
  var weightController = TextEditingController();
  var earringNumberController = TextEditingController();
  var ageController = TextEditingController();
  var gender = ''.obs;
  var breed = ''.obs;
  var vaccunateDatesController = TextEditingController();
  var pastDiseasesController = TextEditingController();

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

      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        int? cattleId = data['id']; // Intentar obtener el id del bovino agregado, puede ser nulo
        print("Cow added successfully.");

        // Agregar historial médico después de agregar el bovino
        await addMedicalHistory(userId, cattleId);

        Get.offNamed('/home'); // Navegar a la página de inicio
      } else {
        print('Error al agregar el bovino: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en la solicitud de agregar bovino: $e');
    }
  }

  Future<void> addMedicalHistory(int userId, int? cattleId) async {
    final url = Uri.parse('http://192.168.1.100:8000/api/v1/medical_histories/');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = jsonEncode({
      'id_user': userId,
      'id_cattle': cattleId ?? null, // Asignar null si cattleId es nulo
      'vaccunate_dates': vaccunateDatesController.text.split(',').map((date) => date.trim()).toList(),
      'past_diseases': pastDiseasesController.text.split(',').map((disease) => disease.trim()).toList(),
      'weight': weightController.text,
      'breed': breed.value,
      'age': ageController.text
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("Medical history added successfully.");
      } else {
        print('Error al agregar el historial médico: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en la solicitud de agregar historial médico: $e');
    }
  }
}
