// lib/presentation/pages/crear_publicacion_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../core/models/bovino_model.dart';

class CrearPublicacionPage extends StatelessWidget {
  final Bovino bovino;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController ubicacionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  CrearPublicacionPage({Key? key, required this.bovino}) : super(key: key);

  Future<void> crearPublicacion() async {
    final storage = GetStorage();
    final userId = storage.read('user')['id']; // Recupera el ID del usuario desde GetStorage

    final headers = {
      'Content-Type': 'application/json'
    };

    final body = json.encode({
      "idCattle": bovino.id,
      "idUser": userId, // Usar el ID del usuario actual
      "description": descriptionController.text,
      "precio": double.tryParse(precioController.text) ?? 0,
      "ubicacion": ubicacionController.text,
      "fecha": fechaController.text,
      "status": "disponible"
    });

    final url = Uri.parse('https://bovisales-backend.onrender.com/api/posts/');

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Publicación creada exitosamente
        print('Publicación creada correctamente');
        Get.back();
      } else {
        // Error en la creación de la publicación
        print('Error creando la publicación: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Publicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ubicacionController,
              decoration: InputDecoration(labelText: 'Ubicación'),
            ),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(labelText: 'Fecha (YYYY-MM-DDTHH:MM:SS)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: crearPublicacion,
              child: Text('Crear Publicación'),
            ),
          ],
        ),
      ),
    );
  }
}
