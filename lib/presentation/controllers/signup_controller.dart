import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignupController extends GetxController {
  // Observables para los campos de texto
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var phoneNumber = ''.obs;

  // Observable para la visibilidad de la contraseña
  var isPasswordVisible = false.obs;

  // Observable para la imagen de perfil
  var profileImagePath = ''.obs;

  // Método para registrar el usuario
  void register() {
    if (name.value.isEmpty || email.value.isEmpty || password.value.isEmpty || phoneNumber.value.isEmpty) {
      Get.snackbar('Error', 'Por favor, complete todos los campos.');
    } else if (!GetUtils.isEmail(email.value)) {
      Get.snackbar('Error', 'Ingrese un email válido.');
    } else {
      // Lógica para registrar el usuario, por ejemplo, llamar a un servicio backend
      Get.snackbar('Registro', 'Usuario registrado con éxito.');
    }
  }

  // Método para alternar la visibilidad de la contraseña
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Método para seleccionar una imagen de perfil
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
      } else {
        Get.snackbar('Error', 'No se seleccionó ninguna imagen.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al seleccionar la imagen.');
    }
  }
}
