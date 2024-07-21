import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/controllers/subscription_controller.dart';
import 'package:bovi_sales/presentation/controllers/navigation_controller.dart';

class PublicacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subscriptionController = Get.find<SubscriptionController>();
    final navigationController = Get.find<NavigationController>();
    final user = GetStorage().read('user');
    final userId = user['id'];

    return Scaffold(
      appBar: AppBar(title: Text('Publicaciones')),
      body: FutureBuilder(
        future: subscriptionController.checkSubscription(userId, navigationController.apiKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (subscriptionController.subscriptionStatus.value == 'Active') {
              // Aquí puedes mostrar el contenido de la página de publicaciones
              return Center(child: Text('Contenido de Publicaciones'));
            } else {
              return Center(child: Text('Necesitas una suscripción activa para acceder a esta sección.'));
            }
          }
        },
      ),
    );
  }
}
