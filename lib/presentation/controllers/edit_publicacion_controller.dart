import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/models/publicacion_model.dart';

class EditPublicacionController extends GetxController {
  GoogleMapController? mapController;
  late TextEditingController descriptionController;
  late TextEditingController precioController;
  Rx<LatLng> selectedLocation = LatLng(0, 0).obs;
  RxSet<Marker> markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    descriptionController = TextEditingController();
    precioController = TextEditingController();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    precioController.dispose();
    super.onClose();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
    mapController!.animateCamera(CameraUpdate.newLatLngZoom(selectedLocation.value, 15));
  }

  void setInitialValues(Publicacion publicacion) async {
    descriptionController.text = publicacion.description;
    precioController.text = publicacion.precio.toString();

    // Convierte la ubicación en coordenadas
    List<Location> locations = await locationFromAddress(publicacion.ubicacion);
    if (locations.isNotEmpty) {
      selectedLocation.value = LatLng(locations[0].latitude, locations[0].longitude);
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: selectedLocation.value,
        infoWindow: InfoWindow(title: 'Ubicación de la Publicación'),
      ));
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(selectedLocation.value, 15));
    }
  }

  Future<void> updatePublicacion(int idCattle) async {
    var body = jsonEncode({
      'idCattle': idCattle.toString(),
      'idUser': '8', // Cambia esto por el ID del usuario logueado
      'description': descriptionController.text,
      'precio': double.parse(precioController.text),
      'ubicacion': '${selectedLocation.value.latitude}, ${selectedLocation.value.longitude}',
      'fecha': DateTime.now().toIso8601String(),
      'status': 'disponible',
    });

    var headers = {
      'Content-Type': 'application/json'
    };

    var request = http.Request('PUT', Uri.parse('http://localhost:3001/api/posts/1'));
    request.body = body;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
