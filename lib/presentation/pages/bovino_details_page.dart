// lib/presentation/pages/bovino_details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bovi_sales/core/models/bovino_model.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class BovinoDetailsPage extends StatelessWidget {
  final Bovino bovino;

  BovinoDetailsPage({required this.bovino});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              // Implementa la lógica de edición aquí
            },
          ),
        ],
        title: Text(
          'Detalles',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: Image.network(
                    bovino.imageUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailRow('Nombre:', bovino.name),
                    SizedBox(height: 8), // Add space between rows
                    buildDetailRow('Edad:', bovino.age.toString()),
                    SizedBox(height: 8), // Add space between rows
                    buildDetailRow('Género:', bovino.gender),
                    SizedBox(height: 8), // Add space between rows
                    buildDetailRow('Raza:', bovino.breed),
                    SizedBox(height: 8), // Add space between rows
                    buildDetailRow('Peso:', '${bovino.weight}kg'),
                    SizedBox(height: 8), // Add space between rows
                    buildDetailRow('Arete:', bovino.earringNumber.toString()),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implementa la lógica de edición aquí
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC67C4E),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Editar datos',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
        selectedIndex: navigationController.selectedIndex.value,
        onTap: (index) {
          navigationController.onItemTapped(index);
        },
      )),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the top
        children: [
          Text(
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
