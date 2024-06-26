// lib/presentation/pages/ganado_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ganado_controller.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class GanadoPage extends StatelessWidget {
  final GanadoController ganadoController = Get.put(GanadoController());
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganado'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text('Página de Ganado'),
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
