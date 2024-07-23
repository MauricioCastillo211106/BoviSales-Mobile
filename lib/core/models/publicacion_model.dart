// lib/core/models/publicacion_model.dart
class Publicacion {
  final int idCattle;
  final String description;
  final int idUser;
  final String precio;
  final String ubicacion;
  final String fecha;
  final String status;
  final String imageUrl; // Nuevo campo para la URL de la imagen

  Publicacion({
    required this.idCattle,
    required this.description,
    required this.idUser,
    required this.precio,
    required this.ubicacion,
    required this.fecha,
    required this.status,
    required this.imageUrl, // Inicialización del nuevo campo
  });

  factory Publicacion.fromJson(Map<String, dynamic> json) {
    return Publicacion(
      idCattle: json['idCattle'] ?? 0,
      description: json['description'] ?? 'Descripción no disponible',
      idUser: json['idUser'] ?? 0,
      precio: json['precio'] ?? '0.0',
      ubicacion: json['ubicacion'] ?? 'Ubicación no disponible',
      fecha: json['fecha'] ?? 'Fecha no disponible',
      status: json['status'] ?? 'Estado no disponible',
      imageUrl: json['imageUrl'] ?? '', // Asignación del nuevo campo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCattle': idCattle,
      'description': description,
      'idUser': idUser,
      'precio': precio,
      'ubicacion': ubicacion,
      'fecha': fecha,
      'status': status,
      'imageUrl': imageUrl, // Conversión del nuevo campo a JSON
    };
  }
}
