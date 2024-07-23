// lib/presentation/bindings/crear_publicacion_binding.dart
import 'package:get/get.dart';
import '../controllers/crear_publicacion_controller.dart';

class CrearPublicacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrearPublicacionController>(() => CrearPublicacionController());
  }
}
