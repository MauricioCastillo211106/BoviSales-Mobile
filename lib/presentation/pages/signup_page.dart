import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../controllers/signup_controller.dart'; // Asegúrate de ajustar la ruta según tu estructura de proyecto

class SignupPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Cuenta', style: TextStyle(fontFamily: 'Sora')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crear cuenta',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.08, // Tamaño de texto dinámico
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Registra y gestiona tu ganado eficientemente',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: screenWidth * 0.04, // Tamaño de texto dinámico
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: Obx(() {
                  return Stack(
                    children: [
                      if (controller.profileImagePath.isNotEmpty)
                        Container(
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(controller.profileImagePath.value)),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Color(0xFFC67C4E),
                              width: 4.0,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC67C4E),
                          ),
                          child: Center(
                            child: Text(
                              'Foto',
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: screenWidth * 0.04,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.pickImage(), // Asegúrate de que esta función se llama al tocar
                          child: CircleAvatar(
                            radius: screenWidth * 0.05,
                            backgroundColor: Color(0xFFA55700),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: screenWidth * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.04),
              TextField(
                decoration: InputDecoration(
                  labelText: 'NOMBRE COMPLETO',
                  labelStyle: TextStyle(fontFamily: 'Sora'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
                  ),
                ),
                onChanged: (value) => controller.name.value = value,
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CORREO ELECTRONICO',
                  labelStyle: TextStyle(fontFamily: 'Sora'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
                  ),
                ),
                onChanged: (value) => controller.email.value = value,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (value) {
                  if (!value.contains('@')) {
                    Get.snackbar('Error', 'Por favor, ingrese un correo electrónico válido.');
                  }
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                decoration: InputDecoration(
                  labelText: 'NUMERO TELEFONICO',
                  labelStyle: TextStyle(fontFamily: 'Sora'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
                  ),
                ),
                onChanged: (value) => controller.phoneNumber.value = value,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Permitir solo números
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Obx(
                    () => TextField(
                  decoration: InputDecoration(
                    labelText: 'CONTRASEÑA',
                    labelStyle: TextStyle(fontFamily: 'Sora'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20), // Esquinas redondeadas
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  onChanged: (value) => controller.password.value = value,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton(
                onPressed: controller.register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA55700),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  Get.back(); // Regresar a la pantalla anterior (Iniciar sesión)
                },
                child: Center(
                  child: Text(
                    '¿Ya tienes una cuenta? Iniciar sesión',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: screenWidth * 0.04,
                      color: Color(0xFFA55700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
