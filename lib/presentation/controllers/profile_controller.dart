// lib/presentation/controllers/profile_controller.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var isSubscribed = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Cargar datos de usuario de almacenamiento o servicio de datos
    var user = GetStorage().read('user') ?? {};
    isSubscribed.value = user['suscription'] == 1;
  }

  void logOut() {
    // Lógica para cerrar sesión
    GetStorage().erase(); // Eliminar datos de usuario
    Get.offAllNamed('/'); // Redirigir al inicio de sesión
  }
}
