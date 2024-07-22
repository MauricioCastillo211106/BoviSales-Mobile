// lib/presentation/bindings/publicaciones_binding.dart
import 'package:get/get.dart';
import '../controllers/publicaciones_controller.dart';
import '../../data/repositories/subscription_repository.dart';

class PublicacionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicacionesController>(() => PublicacionesController());

  }
}
