import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/signup_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Aquí puedes inicializar dependencias globales
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put(SignupController(), permanent: true); // Inicializa el controlador de registro
  }
}
