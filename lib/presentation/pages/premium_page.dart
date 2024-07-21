import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/premium_controller.dart';

class PremiumPage extends StatelessWidget {
  final PremiumController premiumController = Get.put(PremiumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BoviSales Premium'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (premiumController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (premiumController.plans.isEmpty) {
          return Center(child: Text('No se encontraron planes.'));
        } else {
          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.diamond, color: Color(0xFFA55700), size: 100), // Icono de diamante
                  SizedBox(height: 20),
                  Text(
                    '¿Qué incluye Premium?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.store, color: Color(0xFFA55700)),
                            title: Text('Apartado de Ventas'),
                          ),
                          ListTile(
                            leading: Icon(Icons.all_inclusive, color: Color(0xFFA55700)),
                            title: Text('Cupo ilimitado de Ganado'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Planes',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              for (var plan in premiumController.plans)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(plan['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Precio: \$${plan['price']}'),
                        Text('Duración: ${plan['duration']} mes(es)'),
                        Text('Descripción: ${plan['description']}'),
                      ],
                    ),
                    onTap: () {
                      premiumController.subscribeToPlan(plan['plan_id']);
                    },
                  ),
                ),
            ],
          );
        }
      }),
    );
  }
}
