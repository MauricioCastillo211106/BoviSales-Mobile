// lib/presentation/widgets/publicacion_card.dart
import 'package:flutter/material.dart';

class PublicacionCard extends StatelessWidget {
  final Map<String, dynamic> publicacion;

  PublicacionCard({required this.publicacion});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              publicacion['title'],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(publicacion['content']),
          ],
        ),
      ),
    );
  }
}
