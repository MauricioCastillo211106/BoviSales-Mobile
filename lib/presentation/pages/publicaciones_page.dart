import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/publicaciones_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/custom_search_controller.dart' as custom;
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/publicacion_card.dart';
import '../widgets/search_bar.dart' as custom_search;

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
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFC67C4E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Mis publicaciones',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (publicacionesController.bovinos.isEmpty) {
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
                  itemCount: publicacionesController.bovinos.length,
                  itemBuilder: (context, index) {
                    final bovino = publicacionesController.bovinos[index];
                    return PublicationCard(bovino: bovino);
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
