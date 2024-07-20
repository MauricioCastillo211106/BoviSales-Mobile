// lib/presentation/pages/premium_page.dart
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
        } else {
          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Text(
                '¿Qué incluye Premium?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.sell, color: Color(0xFFA55700)),
                  title: Text(
                    'Apartado de Ventas',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.inbox, color: Color(0xFFA55700)),
                  title: Text(
                    'Cupo ilimitado de Gando',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Planes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              ...premiumController.plans.map((plan) {
                return GestureDetector(
                  onTap: () {
                    premiumController.subscribeToPlan(plan['plan_id']);
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        plan['name'],
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Precio: \$${plan['price']}'),
                          Text('Duración: ${plan['duration']} mes(es)'),
                          Text('Descripción: ${plan['description']}'),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }
      }),
    );
  }
}
