// lib/presentation/controllers/crear_publicacion_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../core/models/bovino_model.dart';

class CrearPublicacionController extends GetxController {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  var ubicacion = ''.obs;
  var fecha = ''.obs;
  var ubicacionError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _determinePosition();
    _setCurrentDate();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ubicacionError.value = 'Location services are disabled.';
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ubicacionError.value = 'Location permissions are denied';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ubicacionError.value = 'Location permissions are permanently denied, we cannot request permissions.';
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _getAddressFromLatLng(position);
    } catch (e) {
      ubicacionError.value = 'Failed to get position: $e';
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        ubicacion.value = "${place.locality}, ${place.postalCode}, ${place.country}";
      } else {
        ubicacionError.value = 'No placemarks found.';
      }
    } catch (e) {
      ubicacionError.value = 'Failed to get address: $e';
    }
  }

  void _setCurrentDate() {
    final now = DateTime.now();
    fecha.value = now.toIso8601String(); // Formato ISO 8601
  }

  Future<void> crearPublicacion(Bovino bovino) async {
    final storage = GetStorage();
    final userId = storage.read('user')['id'];

    var headers = {
      'Content-Type': 'application/json'
    };

    // Asegurarse de que idCattle y idUser sean números
    int idCattle = int.tryParse(bovino.id) ?? 0;
    int idUser = userId is String ? int.tryParse(userId) ?? 0 : userId;

    var body = json.encode({
      "idCattle": idCattle,  // Asegurarse de que sea un número
      "idUser": idUser,  // Asegurarse de que sea un número
      "description": descriptionController.text,
      "precio": double.tryParse(precioController.text) ?? 0,
      "ubicacion": ubicacion.value,
      "fecha": fecha.value,
      "status": "disponible"
    });

    var request = http.Request('POST', Uri.parse('https://bovisales-backend.onrender.com/api/posts/'));
    request.body = body;
    request.headers.addAll(headers);

    // Imprimir los datos para depuración
    print('Request Headers: ${request.headers}');
    print('Request Body: $body');

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('Publicación creada correctamente');
        Get.back();
      } else {
        print('Error creando la publicación: ${response.reasonPhrase}');
        print('Response Status: ${response.statusCode}');
        print('Response Body: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      print('Error realizando la solicitud: $e');
    }
  }
}
