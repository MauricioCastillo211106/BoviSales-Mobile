class Publicacion {
  final int idCattle;
  final String description;
  final int idUser;
  final String precio;
  final String ubicacion;
  final String fecha;
  final String status;
  final String imageUrl;
  final String vendedorImageUrl;
  final String vendedorNombre;
  final String vendedorEmail;

  Publicacion({
    required this.idCattle,
    required this.description,
    required this.idUser,
    required this.precio,
    required this.ubicacion,
    required this.fecha,
    required this.status,
    required this.imageUrl,
    required this.vendedorImageUrl,
    required this.vendedorNombre,
    required this.vendedorEmail,
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
      imageUrl: json['imageUrl'] ?? '',
      vendedorImageUrl: json['vendedorImageUrl'] ?? 'https://static.vecteezy.com/system/resources/previews/010/871/350/original/3d-avatar-farmer-png.png',
      vendedorNombre: json['vendedorNombre'] ?? 'Nombre no disponible',
      vendedorEmail: json['vendedorEmail'] ?? 'Email no disponible',
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
      'imageUrl': imageUrl,
      'vendedorImageUrl': vendedorImageUrl,
      'vendedorNombre': vendedorNombre,
      'vendedorEmail': vendedorEmail,
    };
  }
}
