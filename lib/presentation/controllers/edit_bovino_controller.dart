// lib/presentation/controllers/edit_bovino_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/models/bovino_model.dart';

class EditBovinoController extends GetxController {
  var bovino = Bovino(
    id: '',
    name: '',
    breed: '',
    earringNumber: 0,
    age: 0,
    gender: '',
    weight: '',
    imageUrl: '',
  ).obs;

  void setBovino(Bovino bovino) {
    this.bovino.value = bovino;
  }

  Future<void> updateBovino() async {
    final headers = {
      'Content-Type': 'application/json'
    };

    final body = json.encode({
      "name": bovino.value.name,
      "weight": double.tryParse(bovino.value.weight) ?? 0,
      "earringNumber": bovino.value.earringNumber,
      "age": bovino.value.age,
      "gender": bovino.value.gender,
      "breed": bovino.value.breed,
      "image": bovino.value.imageUrl,
    });

    final url = Uri.parse('https://bovisales-backend.onrender.com/api/v1/Cattle/put/${bovino.value.id}');

    print('URL: $url'); // Imprime la URL para depuración

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Actualización exitosa
        print('Bovino actualizado correctamente');
        Get.back();
      } else {
        // Error en la actualización
        print('Error actualizando bovino: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }
}
