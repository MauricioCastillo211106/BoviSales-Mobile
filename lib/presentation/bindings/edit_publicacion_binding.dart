// lib/bindings/edit_publicacion_binding.dart
import 'package:get/get.dart';
import '../controllers/edit_publicacion_controller.dart';

class EditPublicacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPublicacionController>(() => EditPublicacionController());
  }
}
