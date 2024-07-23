// lib/presentation/widgets/publicacion_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicacionCard extends StatelessWidget {
  final Map<String, dynamic> publicacion;

  const PublicacionCard({required this.publicacion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Acción al tocar la tarjeta (puedes implementar la navegación o cualquier otra lógica aquí)
      },
      child: Card(
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
                  publicacion['imageUrl'] ?? '',
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
                    publicacion['name'] ?? 'Nombre no disponible',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    publicacion['breed'] ?? 'Raza no disponible',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        publicacion['earringNumber'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC67C4E),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Color(0xFFC67C4E)), // Icono de lápiz
                        onPressed: () {
                          // Acción de modificación aquí
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
