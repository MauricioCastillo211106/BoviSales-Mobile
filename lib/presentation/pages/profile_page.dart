import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:bovi_sales/presentation/controllers/profile_controller.dart';
import '../controllers/navigation_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final NavigationController navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final user = storage.read('user') ?? {}; // Obtener datos de usuario desde GetStorage
    final bool isSubscribed = user['suscription'] == 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Cuenta', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Sección de información del usuario
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200], // Color de fondo del avatar si no hay imagen
                  backgroundImage: user['image'] != null && user['image'].isNotEmpty
                      ? NetworkImage(user['image'])
                      : null,
                  child: user['image'] == null || user['image'].isEmpty
                      ? Text(
                    user['name']?.substring(0, 1) ?? 'U', // Inicial del nombre
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  )
                      : null,
                ),
                title: Text(
                  user['name'] ?? 'Usuario',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
                onTap: () {
                  // Acción para editar perfil
                },
              ),
            ),
            SizedBox(height: 20),
            // Botón de suscripción premium
            if (!isSubscribed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed('/premium');
                  }, // Navega a la página de suscripción premium
                  icon: Icon(Icons.diamond, color: Colors.white),
                  label: Text(
                    'Vuélvete Premium',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA55700),
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            Divider(),
            // Opciones de perfil con tarjetas y sombras
            _buildProfileOption(
              icon: Icons.list,
              title: 'Mi Ganado',
              onTap: () {
                navigationController.onItemTapped(0); // Actualiza el índice seleccionado
                Get.toNamed('/venta');
              },
            ),
            _buildProfileOption(
              icon: Icons.public,
              title: 'Publicaciones',
              onTap: () {
                navigationController.onItemTapped(1); // Actualiza el índice seleccionado
                Get.toNamed('/publicaciones');
              },
            ),
            _buildProfileOption(
              icon: Icons.lock,
              title: 'Olvide mi contraseña',
              onTap: () {
                // Acción para recuperar contraseña
              },
            ),
            _buildProfileOption(
              icon: Icons.exit_to_app,
              title: 'Cerrar Sesión',
              onTap: () {
                profileController.logOut(); // Acción para cerrar sesión
              },
            ),
          ],
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

  // Método para construir las opciones de perfil como tarjetas con sombras
  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Color(0xFFA55700)),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          onTap: onTap,
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ),
      ),
    );
  }
}
