import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var isSubscribed = false.obs;
  var user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    // Cargar datos de usuario de almacenamiento o servicio de datos
    user.value = GetStorage().read('user') ?? {};
    isSubscribed.value = user['suscription'] == 1;
  }

  void logOut() {
    // Lógica para cerrar sesión
    GetStorage().erase(); // Eliminar datos de usuario
    Get.offAllNamed('/'); // Redirigir al inicio de sesión
  }
}
