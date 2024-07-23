// lib/presentation/controllers/ventas_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/models/bovino_model.dart';

class VentasController extends GetxController {
  var publicaciones = <Publicacion>[].obs;
  var bovinos = <Bovino>[].obs;
  var publicacionesConBovinos = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPublicaciones();
    fetchBovinos();
  }

  Future<void> fetchPublicaciones() async {
    final url = Uri.parse('https://bovisales-backend.onrender.com/api/posts/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        publicaciones.value = data.map((json) => Publicacion.fromJson(json)).toList();
        print('Publicaciones: ${publicaciones.length}');
        publicaciones.forEach((pub) => print(pub.toString()));
        _mapPublicacionesConBovinos();
      } else {
        print('Error al obtener publicaciones: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }

  Future<void> fetchBovinos() async {
    final url = Uri.parse('https://app.cristilex.com/api/v1/Cattle/getAll');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        bovinos.value = data.map((json) => Bovino.fromJson(json)).toList();
        print('Bovinos: ${bovinos.length}');
        bovinos.forEach((bovino) => print(bovino.toString()));
        _mapPublicacionesConBovinos();
      } else {
        print('Error al obtener bovinos: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }

  void _mapPublicacionesConBovinos() {
    if (publicaciones.isNotEmpty && bovinos.isNotEmpty) {
      publicacionesConBovinos.clear();
      for (var publicacion in publicaciones) {
        var bovino = getBovinoById(publicacion.idCattle.toString());
        if (bovino != null) {
          publicacionesConBovinos.add({
            'publicacion': publicacion,
            'bovino': bovino,
          });
        } else {
          print('Bovino no encontrado: ${publicacion.idCattle}');
        }
      }
      print('Publicaciones con Bovinos: ${publicacionesConBovinos.length}');
    }
  }

  Bovino? getBovinoById(String id) {
    try {
      final bovino = bovinos.firstWhere((bovino) => bovino.id == id);
      print('Bovino encontrado: ${bovino.toString()}');
      return bovino;
    } catch (e) {
      print('Bovino no encontrado: $id');
      return null;
    }
  }
}

class Publicacion {
  final int idCattle;
  final int idUser;
  final String description;
  final double precio;
  final String ubicacion;
  final String fecha;
  final String status;

  Publicacion({
    required this.idCattle,
    required this.idUser,
    required this.description,
    required this.precio,
    required this.ubicacion,
    required this.fecha,
    required this.status,
  });

  factory Publicacion.fromJson(Map<String, dynamic> json) {
    return Publicacion(
      idCattle: json['idCattle'],
      idUser: json['idUser'],
      description: json['description'],
      precio: double.parse(json['precio']),
      ubicacion: json['ubicacion'],
      fecha: json['fecha'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'Publicacion{idCattle: $idCattle, idUser: $idUser, description: $description, precio: $precio, ubicacion: $ubicacion, fecha: $fecha, status: $status}';
  }
}
