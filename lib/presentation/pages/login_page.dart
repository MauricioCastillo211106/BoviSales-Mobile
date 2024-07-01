import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Iniciar Sesión'),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Accede a tu cuenta para gestionar tu ganado',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 80),
            // Campo para el correo electrónico con validación
            Obx(() => TextField(
              controller: loginController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                errorText: loginController.emailError.value.isNotEmpty ? loginController.emailError.value : null,
              ),
              onChanged: (value) {
                loginController.validateEmail(value);
              },
            )),
            SizedBox(height: 80),
            // Campo para la contraseña con icono para mostrar/ocultar
            Obx(() => TextField(
              controller: loginController.passwordController,
              obscureText: loginController.isPasswordHidden.value,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    loginController.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    loginController.togglePasswordVisibility();
                  },
                ),
              ),
            )),
            SizedBox(height: 100),
            // Botón para iniciar sesión
            ElevatedButton(
              onPressed: () async {
                await loginController.login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA55700),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Texto para registrarse
            TextButton(
              onPressed: () {
                Get.toNamed('/signup'); // Navegar a la página de registro
              },
              child: Text(
                '¿No tienes una cuenta? Regístrate',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 16,
                  color: Color(0xFFC67C4E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
