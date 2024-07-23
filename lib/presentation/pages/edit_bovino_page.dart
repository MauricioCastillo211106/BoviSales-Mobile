// lib/presentation/pages/edit_bovino_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_bovino_controller.dart';
import '../../core/models/bovino_model.dart';

class EditBovinoPage extends StatelessWidget {
  final Bovino bovino;

  const EditBovinoPage({required this.bovino});

  @override
  Widget build(BuildContext context) {
    final EditBovinoController controller = Get.put(EditBovinoController(bovino));

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Datos del Bovino'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: controller.breedController,
              decoration: InputDecoration(labelText: 'Raza'),
            ),
            TextField(
              controller: controller.weightController,
              decoration: InputDecoration(labelText: 'Peso'),
            ),
            TextField(
              controller: controller.ageController,
              decoration: InputDecoration(labelText: 'Edad'),
            ),
            TextField(
              controller: controller.genderController,
              decoration: InputDecoration(labelText: 'Género'),
            ),
            TextField(
              controller: controller.earringNumberController,
              decoration: InputDecoration(labelText: 'Número de Arete'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateBovino();
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
