// lib/presentation/pages/edit_bovino_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_bovino_controller.dart';
import '../../core/models/bovino_model.dart';

class EditBovinoPage extends StatelessWidget {
  final EditBovinoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final Bovino bovino = Get.arguments;
    controller.setBovino(bovino);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Bovino'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: controller.bovino.value.name),
              decoration: InputDecoration(labelText: 'Nombre'),
              onChanged: (value) => controller.bovino.update((val) {
                val?.name = value;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.breed),
              decoration: InputDecoration(labelText: 'Raza'),
              onChanged: (value) => controller.bovino.update((val) {
                val?.breed = value;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.earringNumber.toString()),
              decoration: InputDecoration(labelText: 'Número de Arete'),
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.bovino.update((val) {
                val?.earringNumber = int.tryParse(value) ?? 0;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.age.toString()),
              decoration: InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
              onChanged: (value) => controller.bovino.update((val) {
                val?.age = int.tryParse(value) ?? 0;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.gender),
              decoration: InputDecoration(labelText: 'Género'),
              onChanged: (value) => controller.bovino.update((val) {
                val?.gender = value;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.weight),
              decoration: InputDecoration(labelText: 'Peso'),
              onChanged: (value) => controller.bovino.update((val) {
                val?.weight = value;
              }),
            ),
            TextField(
              controller: TextEditingController(text: controller.bovino.value.imageUrl),
              decoration: InputDecoration(labelText: 'URL de la imagen'),
              onChanged: (value) => controller.bovino.update((val) {
                val?.imageUrl = value;
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateBovino();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
