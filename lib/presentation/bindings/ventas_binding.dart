// lib/presentation/bindings/ventas_binding.dart
import 'package:get/get.dart';
import '../controllers/ventas_controller.dart';

class VentasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VentasController>(() => VentasController());
  }
}
