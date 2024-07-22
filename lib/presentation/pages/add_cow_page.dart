import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_cow_controller.dart';

class AddCowPage extends StatelessWidget {
  final AddCowController addCowController = Get.put(AddCowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Vaca'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Añadir Vaca',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Registra los detalles de tu ganado',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => addCowController.pickImage(),
              child: Obx(() => Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: addCowController.imagePath.isEmpty
                    ? Icon(Icons.camera_alt, size: 50)
                    : Image.file(File(addCowController.imagePath.value)),
              )),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.earringNumberController,
              decoration: InputDecoration(
                labelText: 'Num. Arete',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.ageController,
              decoration: InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.weightController,
              decoration: InputDecoration(
                labelText: 'Peso Actual',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: addCowController.gender.value.isNotEmpty ? addCowController.gender.value : null,
              onChanged: (String? newValue) {
                addCowController.gender.value = newValue!;
              },
              items: <String>['male', 'famale'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Género',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: addCowController.breed.value.isNotEmpty ? addCowController.breed.value : null,
              onChanged: (String? newValue) {
                addCowController.breed.value = newValue!;
              },
              items: <String>['Brahman', 'BrownSwiss', 'Holstein', 'Charolais', 'Simmental']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Seleccione la Raza',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await addCowController.addCow();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA55700),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Agregar Bovino',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
