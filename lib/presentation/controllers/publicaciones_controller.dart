// lib/presentation/controllers/publicaciones_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/models/bovino_model.dart';

class PublicacionesController extends GetxController {
  var publicaciones = <Bovino>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPublicaciones();
  }

  Future<void> fetchPublicaciones() async {
    final url = Uri.parse('https://bovisales-backend.onrender.com/api/posts/user/21');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        publicaciones.value = data.map((json) => Bovino.fromJson(json)).toList();
      } else {
        print('Error al obtener publicaciones: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }
}
