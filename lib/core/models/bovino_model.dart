class Bovino {
  final String name;
  final String breed;
  final int earringNumber;
  final int age;
  final String gender;
  final String weight;
  final String? imageUrl;

  Bovino({
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
      name: json['name'],
      breed: json['breed'],
      earringNumber: json['earringNumber'],
      age: json['age'],
      gender: json['gender'],
      weight: json['weight'],
      imageUrl: json['image'],
    );
  }
}
