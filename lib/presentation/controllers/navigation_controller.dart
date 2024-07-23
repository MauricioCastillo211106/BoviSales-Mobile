import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'subscription_controller.dart';
import 'package:bovi_sales/data/repositories/subscription_repository.dart';
import 'home_controller.dart';

class NavigationController extends GetxController {
  final SubscriptionRepository repository;
  final String apiKey;
  var selectedIndex = 0.obs;
  late final SubscriptionController subscriptionController;

  NavigationController({required this.repository, required this.apiKey}) {
    subscriptionController = Get.find<SubscriptionController>();
  }

  void resetIndex() {
    selectedIndex.value = 0;
  }

  void onItemTapped(int index) async {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/home')?.then((_) {
          HomeController homeController = Get.find<HomeController>();
          homeController.fetchBovinos(); // Refrescar los datos cada vez que se navega a home
        });
        break;
      case 1:
        await _checkSubscriptionAndNavigate('/publicaciones');
        break;
      case 2:
        await _checkSubscriptionAndNavigate('/venta');
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

  Future<void> _checkSubscriptionAndNavigate(String route) async {
    final storage = GetStorage();
    final user = storage.read('user');
    final userId = user['id'];

    try {
      await subscriptionController.checkSubscription(userId, apiKey);
      if (subscriptionController.subscriptionStatus.value == 'Active') {
        Get.toNamed(route);
      } else {
        Get.snackbar('Acceso Denegado', 'Necesitas una suscripción activa para acceder a esta sección.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Ocurrió un error al verificar la suscripción.');
    }
  }
}
