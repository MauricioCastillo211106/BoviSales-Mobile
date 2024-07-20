import 'package:get/get.dart';
import '../controllers/home_controller.dart'; // Importa el HomeController

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void resetIndex() {
    selectedIndex.value = 0;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/home')?.then((_) {
          HomeController homeController = Get.find<HomeController>();
          homeController.fetchBovinos(); // Refrescar los datos cada vez que se navega a home
        });
        break;
      case 1:
        Get.toNamed('/publicaciones');
        break;
      case 2:
        Get.toNamed('/venta');
        break;
      case 3:
        Get.toNamed('/profile');
        break;
      default:
        Get.toNamed('/home');
    }
  }

  void navigateTo(int index) {
    selectedIndex.value = index;
    onItemTapped(index);
  }
}
