import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class PublicacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publicaciones')),
      body: Center(
        child: Text('Página de Publicaciones'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home');
              break;
            case 1:
            // Ya estamos en la página de publicaciones
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