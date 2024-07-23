import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/models/bovino_model.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var bovinos = <Bovino>[].obs;
  final user = GetStorage().read('user') ?? {};

  @override
  void onInit() {
    super.onInit();
    fetchBovinos();
  }

  Future<void> fetchBovinos() async {
    try {
      final userId = user['id'];
      if (userId == null) {
        throw Exception('User ID is null');
      }
      final response = await http.get(Uri.parse('https://app.cristilex.com/api/v1/user/cattle/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data']; // Asegúrate de acceder a la clave correcta
        bovinos.value = data.map((json) => Bovino.fromJson(json)).toList();
      } else {
        print('Failed to load bovinos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching bovinos: $e');
    }
  }

  void refreshBovinos() {
    fetchBovinos();
  }
}
