import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Aquí puedes inicializar dependencias globales
    Get.put(SignupController(), permanent: true); // Inicializa el controlador de registro
  }
}
