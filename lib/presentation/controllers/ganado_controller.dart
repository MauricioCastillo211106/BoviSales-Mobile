// lib/presentation/controllers/ganado_controller.dart
import 'package:get/get.dart';
import '../../core/models/bovino_model.dart';

class GanadoController extends GetxController {
  var bovinos = <Bovino>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Cargar datos de los bovinos aquí
    bovinos.addAll([
      Bovino('Lola', 'Holstein', 874520, 'https://link.to/image1.jpg'),
      Bovino('Lola', 'Holstein', 874520, 'https://link.to/image2.jpg'),
      // Agrega más bovinos según sea necesario
    ]);
  }
}
