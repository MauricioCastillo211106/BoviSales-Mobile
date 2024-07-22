// lib/core/models/bovino_model.dart
class Bovino {
  String id;
  String name;
  String breed;
  int earringNumber;
  int age;
  String gender;
  String weight;
  String? imageUrl;

  Bovino({
    required this.id,
    required this.name,
    required this.breed,
    required this.earringNumber,
    required this.age,
    required this.gender,
    required this.weight,
    this.imageUrl,
  });

  factory Bovino.fromJson(Map<String, dynamic> json) {
    return Bovino(
      id: json['id'].toString(), // Asegúrate de convertir a String si es necesario
      name: json['name'],
      breed: json['breed'],
      earringNumber: json['earringNumber'] is String ? int.parse(json['earringNumber']) : json['earringNumber'],
      age: json['age'] is String ? int.parse(json['age']) : json['age'],
      gender: json['gender'],
      weight: json['weight'].toString(), // Asegúrate de convertir a String si es necesario
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'earringNumber': earringNumber,
      'age': age,
      'gender': gender,
      'weight': weight,
      'imageUrl': imageUrl,
    };
  }
}
