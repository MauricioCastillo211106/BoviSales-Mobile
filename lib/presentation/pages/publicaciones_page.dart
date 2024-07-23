// lib/presentation/pages/publicaciones_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/publicaciones_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/custom_search_controller.dart' as custom;
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/search_bar.dart' as custom_search;
import '../widgets/publicacion_card.dart'; // Importa PublicacionCard
import '../../core/models/publicacion_model.dart';
import '../../core/models/bovino_model.dart';

class PublicacionesPage extends StatelessWidget {
  final PublicacionesController publicacionesController = Get.put(PublicacionesController());
  final NavigationController navigationController = Get.find<NavigationController>();
  final custom.CustomSearchController searchController = Get.put(custom.CustomSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 10.0),
            child: Column(
              children: [
                AppBar(
                  title: Text('Mis Publicaciones', style: TextStyle(color: Colors.white)),
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                custom_search.SearchBar(
                  controller: searchController.searchController.value,
                  onSearch: (query) {
                    // Implementa la lógica de búsqueda aquí
                  },
                  onFilter: () {
                    // Implementa la lógica de filtrado aquí
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed('/add_cow');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC67C4E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Publica a tu bovino',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (publicacionesController.publicaciones.isEmpty) {
                return Center(child: Text('No hay publicaciones disponibles'));
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: publicacionesController.publicaciones.length,
                  itemBuilder: (context, index) {
                    final publicacion = publicacionesController.publicaciones[index];
                    final bovino = publicacionesController.bovinos.firstWhere(
                          (bovino) => bovino.id == publicacion.idCattle.toString(), // Convertir idCattle a String
                      orElse: () => Bovino(
                        id: publicacion.idCattle.toString(), // Convertir idCattle a String
                        name: publicacion.description,
                        breed: "Raza no disponible",
                        earringNumber: publicacion.idCattle,
                        age: 0,
                        gender: "Género no disponible",
                        weight: "Peso no disponible",
                        imageUrl: '', // Aquí debería ir una URL de imagen por defecto
                      ),
                    );

                    return GestureDetector(
                      onTap: () {
                        // Navegar a los detalles de la publicación
                        // Implementa la lógica si es necesario
                      },
                      child: PublicacionCard(publicacion: {
                        'name': bovino.name,
                        'breed': bovino.breed,
                        'earringNumber': bovino.earringNumber,
                        'description': publicacion.description,
                        'precio': publicacion.precio,
                        'ubicacion': publicacion.ubicacion,
                        'fecha': publicacion.fecha,
                        'status': publicacion.status,
                        'imageUrl': bovino.imageUrl // Usa la URL de la imagen del bovino
                      }),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
        selectedIndex: navigationController.selectedIndex.value,
        onTap: (index) {
          navigationController.onItemTapped(index);
        },
      )),
    );
  }
}
