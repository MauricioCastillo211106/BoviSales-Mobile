import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/signup_controller.dart';

class SignupPage extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Crear cuenta'),
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
              'Crear cuenta',
              style: TextStyle(
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Registra y gestiona tu ganado eficientemente',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            // Widget para seleccionar imagen de perfil
            GestureDetector(
              onTap: () async {
                await signupController.pickImage();
              },
              child: Stack(
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFA55700),
                    backgroundImage: signupController.imagePath.value.isEmpty
                        ? null
                        : FileImage(File(signupController.imagePath.value)),
                    child: signupController.imagePath.value.isEmpty
                        ? Text(
                      'Foto',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        color: Colors.white,
                      ),
                    )
                        : null,
                  )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.brown, // Color del icono de +
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Campo para el nombre
            TextField(
              controller: signupController.nameController,
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Campo para el correo electrónico con validación
            Obx(() => TextField(
              controller: signupController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                errorText: signupController.isEmailValid.value ? null : 'Ingrese un correo electrónico válido',
              ),
              onChanged: (value) {
                signupController.validateEmail(value);
              },
            )),
            SizedBox(height: 20),
            // Campo para el número de teléfono
            TextField(
              controller: signupController.phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número Telefónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Campo para la contraseña con icono para mostrar/ocultar
            Obx(() => TextField(
              controller: signupController.passwordController,
              obscureText: signupController.isPasswordHidden.value,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    signupController.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    signupController.togglePasswordVisibility();
                  },
                ),
              ),
            )),
            SizedBox(height: 70), // Aumentar el espacio entre los inputs y los botones
            // Botón para crear la cuenta
            Obx(() => ElevatedButton(
              onPressed: signupController.isLoading.value ? null : () async {
                if (signupController.validateInputs()) {
                  await signupController.createUser();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA55700),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: signupController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                'Crear cuenta',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )),
            SizedBox(height: 10),
            // Texto para iniciar sesión
            TextButton(
              onPressed: () {
                Get.toNamed('/login'); // Asegúrate de tener una ruta '/login' o reemplaza con la correcta
              },
              child: Text(
                '¿Ya tienes una cuenta? Iniciar sesión',
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
