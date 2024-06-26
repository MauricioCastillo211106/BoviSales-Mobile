// lib/presentation/controllers/publicaciones_controller.dart
import 'package:get/get.dart';
import '../../core/models/bovino_model.dart';

class PublicacionesController extends GetxController {
  var publicaciones = <Bovino>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Cargar datos de las publicaciones aquí
    publicaciones.addAll([
      Bovino('Lola', 'Holstein', 874520, 'https://link.to/image1.jpg'),
      Bovino('Lola', 'Holstein', 874520, 'https://link.to/image2.jpg'),
      // Agrega más publicaciones según sea necesario
    ]);
  }
}
