// lib/presentation/bindings/edit_bovino_binding.dart
import 'package:get/get.dart';
import '../controllers/edit_bovino_controller.dart';
import '../../core/models/bovino_model.dart';

class EditBovinoBinding extends Bindings {
  @override
  void dependencies() {
    final Bovino bovino = Get.arguments as Bovino;
    Get.lazyPut<EditBovinoController>(() => EditBovinoController(bovino));
  }
}
