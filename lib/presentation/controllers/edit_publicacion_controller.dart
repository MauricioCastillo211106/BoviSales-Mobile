// lib/presentation/controllers/edit_publicacion_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/models/publicacion_model.dart';

class EditPublicacionController extends GetxController {
  late TextEditingController descriptionController;
  late TextEditingController precioController;

  @override
  void onInit() {
    super.onInit();
    descriptionController = TextEditingController();
    precioController = TextEditingController();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    precioController.dispose();
    super.onClose();
  }

  void setInitialValues(Publicacion publicacion) {
    descriptionController.text = publicacion.description;
    precioController.text = publicacion.precio.toString();
  }

  void updatePublicacion(int idCattle) {
    // Implementar la lógica de actualización aquí
  }
}
