// lib/presentation/pages/venta_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/models/bovino_model.dart';
import '../controllers/ventas_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/custom_search_controller.dart' as custom;
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/venta_card.dart';
import '../widgets/search_bar.dart' as custom_search;

class VentaPage extends StatelessWidget {
  final VentasController ventasController = Get.put(VentasController());
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
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: custom_search.SearchBar(
                    controller: searchController.searchController.value,
                    onSearch: (query) {
                      // Implementa la lógica de búsqueda aquí
                    },
                    onFilter: () {
                      // Implementa la lógica de filtrado aquí
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Acción para agregar una nueva publicación
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFC67C4E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Bovinos en venta',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (ventasController.publicacionesConBovinos.isEmpty) {
                return Center(child: Text('No hay publicaciones disponibles'));
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: ventasController.publicacionesConBovinos.length,
                  itemBuilder: (context, index) {
                    final item = ventasController.publicacionesConBovinos[index];
                    final publicacion = item['publicacion'] as Publicacion;
                    final bovino = item['bovino'] as Bovino;
                    return VentaCard(
                      bovino: bovino,
                      precio: publicacion.precio.toString(),
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
