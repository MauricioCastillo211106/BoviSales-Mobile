// lib/presentation/bindings/ganado_binding.dart
import 'package:get/get.dart';
import '../controllers/ganado_controller.dart';

class GanadoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GanadoController>(() => GanadoController());
  }
}
