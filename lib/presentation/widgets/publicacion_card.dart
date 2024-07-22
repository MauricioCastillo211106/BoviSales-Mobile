import 'package:flutter/material.dart';
import '../../core/models/bovino_model.dart';

class PublicationCard extends StatelessWidget {
  final Bovino bovino;

  PublicationCard({required this.bovino});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  bovino.imageUrl ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              bovino.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              bovino.breed,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              bovino.earringNumber.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Color(0xFFC67C4E)),
                  onPressed: () {
                    // Implementa la lógica de edición aquí
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
