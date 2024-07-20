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
          return Center(child: Text('No se encontraron planes'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.diamond, size: 80, color: Color(0xFFA55700)),
                      SizedBox(height: 10),
                      Text(
                        '¿Qué incluye Premium?',
                        style: TextStyle(
                          fontFamily: 'Sora',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
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
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Planes',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: premiumController.plans.map((plan) {
                    return GestureDetector(
                      onTap: () {
                        premiumController.subscribeToPlan(plan['plan_id']);
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan['name'],
                                style: TextStyle(
                                  fontFamily: 'Sora',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('Precio: \$${plan['price']}'),
                              Text('Duración: ${plan['duration']} mes(es)'),
                              Text('Descripción: ${plan['description']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
