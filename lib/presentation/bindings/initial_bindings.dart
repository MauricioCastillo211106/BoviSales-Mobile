// lib/presentation/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/ganado_controller.dart';
import '../controllers/publicaciones_controller.dart';
import '../controllers/custom_search_controller.dart';
import '../controllers/subscription_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController(
      repository: Get.find(),
      apiKey: 'your_api_key_here',
    ));
    Get.lazyPut<SubscriptionController>(() => SubscriptionController(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GanadoController>(() => GanadoController());
    Get.lazyPut<PublicacionesController>(() => PublicacionesController());
    Get.lazyPut<CustomSearchController>(() => CustomSearchController());
  }
}
