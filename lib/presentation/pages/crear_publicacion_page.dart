// lib/presentation/pages/crear_publicacion_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/crear_publicacion_controller.dart';
import '../../core/models/bovino_model.dart';

class CrearPublicacionPage extends StatelessWidget {
  final CrearPublicacionController controller = Get.put(CrearPublicacionController());
  final Bovino bovino;

  CrearPublicacionPage({Key? key, required this.bovino}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Publicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Agregar SingleChildScrollView
          child: Column(
            children: [
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: controller.precioController,
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              Obx(() {
                if (controller.ubicacionError.isNotEmpty) {
                  return Text('Error: ${controller.ubicacionError.value}', style: TextStyle(color: Colors.red));
                } else if (controller.ubicacion.isEmpty) {
                  return Text('Obteniendo ubicación...');
                } else {
                  return Text('Ubicación: ${controller.ubicacion.value}');
                }
              }),
              Obx(() => Text('Fecha: ${controller.fecha.value}')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (controller.ubicacion.isNotEmpty) {
                    controller.crearPublicacion(bovino);
                  } else {
                    Get.snackbar('Error', 'No se puede crear la publicación sin la ubicación');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC67C4E),
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Publicar Bovino',
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
      ),
    );
  }
}
