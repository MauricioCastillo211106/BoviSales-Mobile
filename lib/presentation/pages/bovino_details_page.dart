import 'package:flutter/material.dart';
import 'package:bovi_sales/core/models/bovino_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BovinoDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bovino bovino = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  bovino.imageUrl ?? 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 200);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre: ${bovino.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Edad: ${bovino.age}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Género: ${bovino.gender}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Raza: ${bovino.breed}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Peso: ${bovino.weight}kg',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Número de Arete: ${bovino.earringNumber}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implementar la funcionalidad de edición si es necesario
                },
                child: Text('Editar datos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC67C4E),
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
