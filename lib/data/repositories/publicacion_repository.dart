import 'package:http/http.dart' as http;
import 'dart:convert';

class PublicacionRepository {
  final http.Client client;

  PublicacionRepository(this.client);

  Future<void> updatePublicacion(int publicacionId, String description, double price, double latitude, double longitude) async {
    final url = 'https://bobi.cristilex.com/api/v1/publicaciones/$publicacionId';
    final body = jsonEncode({
      'description': description,
      'price': price,
      'latitude': latitude,
      'longitude': longitude,
    });

    final response = await client.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update publication');
    }
  }
}
