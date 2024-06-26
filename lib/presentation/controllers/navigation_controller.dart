// lib/presentation/controllers/navigation_controller.dart
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/home');
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
      default:
        Get.toNamed('/home');
    }
  }
}
