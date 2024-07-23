import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import '../../core/models/publicacion_model.dart';
import '../../core/models/bovino_model.dart';

class PublicacionesController extends GetxController {
  var publicaciones = <Publicacion>[].obs;
  var bovinos = <Bovino>[].obs;
  final user = GetStorage().read('user') ?? {};

  @override
  void onInit() {
    super.onInit();
    fetchPublicaciones();
  }

  Future<void> fetchPublicaciones() async {
    try {
      final userId = user['id'];
      if (userId == null) {
        throw Exception('User ID is null');
      }

      // Ignorar errores de certificado SSL (solo para depuración)
      HttpClient httpClient = HttpClient()
        ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      IOClient ioClient = IOClient(httpClient);

      final response = await ioClient.get(Uri.parse('https://app.cristilex.com/api/posts/user/$userId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
          List<dynamic> data = responseData['data'];
          List<Publicacion> publicacionesList = data.map((json) => Publicacion.fromJson(json)).toList();
          publicaciones.value = publicacionesList;

          for (var publicacion in publicacionesList) {
            await fetchBovinoDetails(publicacion.idCattle);
          }
        } else {
          print('Error al obtener publicaciones: ${responseData['message']}');
        }
      } else {
        print('Failed to load publicaciones: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching publicaciones: $e');
    }
  }

  Future<void> fetchBovinoDetails(int idCattle) async {
    try {
      final response = await http.get(Uri.parse('https://app.cristilex.com/api/v1/cattle/$idCattle'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)['data'];
        Bovino bovino = Bovino.fromJson(data);
        bovinos.add(bovino); // Agregar el bovino a la lista
      } else {
        print('Failed to load bovino details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching bovino details: $e');
    }
  }

  void refreshPublicaciones() {
    fetchPublicaciones();
  }
}
