import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Página de Inicio'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
            // Ya estamos en la página de inicio
              break;
            case 1:
              Get.toNamed('/publicaciones');
              break;
            case 2:
              Get.toNamed('/ganado');
              break;
            case 3:
              Get.toNamed('/profile');
              break;
          }
        },
      ),
    );
  }
}