import 'package:flutter/material.dart';
import 'package:bovi_sales/core/models/bovino_model.dart';

class BovinoCard extends StatelessWidget {
  final Bovino bovino;

  const BovinoCard({required this.bovino});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                bovino.imageUrl ?? '', // Asegúrate de que el campo sea el correcto
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bovino.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  bovino.breed ?? '',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bovino.earringNumber.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC67C4E),
                      ),
                    ),
                    Icon(
                      Icons.store,
                      color: Color(0xFFC67C4E),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
