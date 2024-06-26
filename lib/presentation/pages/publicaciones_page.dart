// lib/presentation/pages/publicaciones_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/publicaciones_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class PublicacionesPage extends StatelessWidget {
  final PublicacionesController publicacionesController = Get.put(PublicacionesController());
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Publicaciones'),
      ),
      body: Center(
        child: Text('Página de Publicaciones'),
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
