// lib/presentation/bindings/edit_bovino_binding.dart
import 'package:get/get.dart';
import '../controllers/edit_bovino_controller.dart';

class EditBovinoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditBovinoController>(() => EditBovinoController());
  }
}
