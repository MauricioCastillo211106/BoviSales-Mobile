import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/controllers/premium_controller.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final premiumController = Get.find<PremiumController>();
    final user = GetStorage().read('user');
    final userId = user['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BoviSales Premium',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (premiumController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (premiumController.errorMessage.isNotEmpty) {
          return Center(child: Text(premiumController.errorMessage.value));
        }

        if (premiumController.plans.isEmpty) {
          return Center(child: Text('No se encontraron planes.'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.diamond,
                        size: 60,
                        color: Color(0xFFB27046),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '¿Qué incluye Premium?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.bar_chart, color: Color(0xFFB27046)),
                    title: Text('Apartado de Ventas'),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Icon(Icons.assignment, color: Color(0xFFB27046)),
                    title: Text('Cupo ilimitado de Gando'),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Planes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: premiumController.plans.length,
                  itemBuilder: (context, index) {
                    final plan = premiumController.plans[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Center(
                          child: Text(
                            '${plan['duration']} Meses',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          premiumController.subscribeToPlan(userId, plan['plan_id']);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
