import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class GanadoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ganado')),
      body: Center(
        child: Text('Página de Ganado'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home');
              break;
            case 1:
              Get.toNamed('/publicaciones');
              break;
            case 2:
            // Ya estamos en la página de ganado
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