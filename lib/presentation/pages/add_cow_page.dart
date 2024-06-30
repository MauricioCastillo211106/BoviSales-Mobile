// lib/presentation/pages/add_cow_page.dart
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Añadir Vaca',
              style: TextStyle(
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Registra los detalles de tu ganado',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                addCowController.pickImage();
              },
              child: Stack(
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFA55700),
                    backgroundImage: addCowController.imagePath.value.isEmpty
                        ? null
                        : FileImage(File(addCowController.imagePath.value)),
                    child: addCowController.imagePath.value.isEmpty
                        ? Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.brown,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: addCowController.earringNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'NUM. ARETE',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.nameController,
              decoration: InputDecoration(
                labelText: 'NOMBRE',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
              value: addCowController.gender.value.isEmpty ? null : addCowController.gender.value,
              items: ['male', 'famale'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                addCowController.gender.value = newValue ?? '';
              },
              decoration: InputDecoration(
                labelText: 'GENERO',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'EDAD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => DropdownButtonFormField<String>(
              value: addCowController.breed.value.isEmpty ? null : addCowController.breed.value,
              items: ['Brahman', 'BrownSwiss', 'Holstein', 'Charolais', 'Simmental'].map((String breed) {
                return DropdownMenuItem<String>(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
              onChanged: (String? newValue) {
                addCowController.breed.value = newValue ?? '';
              },
              decoration: InputDecoration(
                labelText: 'SELECCIONE LA RAZA',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )),
            SizedBox(height: 20),
            TextField(
              controller: addCowController.weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'PESO ACTUAL',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 70),
            Obx(() => ElevatedButton(
              onPressed: addCowController.imagePath.value.isEmpty
                  ? null
                  : () async {
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
                'Agregar Vaca',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
