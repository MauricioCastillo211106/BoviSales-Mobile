// lib/presentation/controllers/edit_bovino_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/bovino_model.dart';
import 'package:http/http.dart' as http;

class EditBovinoController extends GetxController {
  final Bovino bovino;

  EditBovinoController(this.bovino);

  final nameController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final earringNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = bovino.name;
    breedController.text = bovino.breed;
    weightController.text = bovino.weight.toString();
    ageController.text = bovino.age.toString();
    genderController.text = bovino.gender;
    earringNumberController.text = bovino.earringNumber.toString();
  }

  Future<void> updateBovino() async {
    final updatedBovino = Bovino(
      id: bovino.id,
      name: nameController.text,
      breed: breedController.text,
      weight: weightController.text,
      age: int.parse(ageController.text),
      gender: genderController.text,
      earringNumber: int.parse(earringNumberController.text),
      imageUrl: bovino.imageUrl,
    );

    final url = Uri.parse('https://bovisales-backend.onrender.com/api/v1/Cattle/put/${bovino.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: updatedBovino.toJson(),
    );

    if (response.statusCode == 200) {
      Get.back(result: updatedBovino);
    } else {
      Get.snackbar('Error', 'No se pudo actualizar el bovino');
    }
  }
}
