// lib/presentation/pages/publicaciones_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bovi_sales/presentation/controllers/publicaciones_controller.dart';
import 'package:bovi_sales/core/models/bovino_model.dart';

class PublicacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PublicacionesController publicacionesController = Get.find<PublicacionesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              publicacionesController.refreshBovinos();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (publicacionesController.bovinos.isEmpty) {
          return Center(child: Text('No hay bovinos disponibles'));
        } else {
          return ListView.builder(
            itemCount: publicacionesController.bovinos.length,
            itemBuilder: (context, index) {
              final bovino = publicacionesController.bovinos[index];
              return ListTile(
                title: Text(bovino.name),
                subtitle: Text('Número de Arete: ${bovino.earringNumber}'),
                onTap: () {
                  Get.toNamed('/edit_bovino', arguments: bovino);
                },
              );
            },
          );
        }
      }),
    );
  }
}
