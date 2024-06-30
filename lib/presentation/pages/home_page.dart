// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/custom_search_controller.dart' as custom;
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/search_bar.dart' as custom_search;
import '../widgets/bovino_card.dart'; // Asegúrate de importar BovinoCard
import 'bovino_details_page.dart'; // Importa la página de detalles

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
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
                'Agregar a tu bovino',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (homeController.bovinos.isEmpty) {
                return Center(child: Text('No hay bovinos disponibles'));
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: homeController.bovinos.length,
                  itemBuilder: (context, index) {
                    final bovino = homeController.bovinos[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => BovinoDetailsPage(bovino: bovino));
                      },
                      child: BovinoCard(bovino: bovino),
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
