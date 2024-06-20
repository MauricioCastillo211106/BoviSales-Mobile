import 'package:bovi_sales/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, -screenHeight * 0.2), // Ajuste dinámico según la altura de la pantalla
              child: Image.asset(
                'assets/images/BoviSales(Onboarding).jpg', // Ruta correcta a tu imagen
                fit: BoxFit.cover, // Asegurarse de que la imagen cubra toda la pantalla
                alignment: Alignment.center, // Alinear la imagen para centrado más preciso
              ),
            ),
          ),
          // Texto principal sobre la imagen

          // Contenedor inferior con degradado
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05, horizontal: screenWidth * 0.05),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF281613),
                    Color(0xFF121514),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.02), // Espacio dinámico para el texto principal
                  Text(
                    'Gestiona y comercializa eficazmente tu ganado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: screenWidth * 0.04, // Tamaño de texto dinámico
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/signup'); // Navegar a la página de registro
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA55700),
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 18,
                        color: Colors.white, // Establecer el color del texto a blanco
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),
                  // Texto para "Iniciar Sesión"
                  GestureDetector(
                    onTap: () {
                      print('Iniciar Sesión pulsado');
                      Get.toNamed('/login'); //Navegar a la página de inicio de sesión, si es necesario
                    },
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: screenWidth * 0.04, // Tamaño de texto dinámico
                        color: Color(0xFFC67C4E), // Aplicar el color especificado
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.60, // Ajustar la posición vertical para mover el texto más abajo
            left: screenWidth * 0.1, // Añadir margen horizontal dinámico
            right: screenWidth * 0.1, // Añadir margen horizontal dinámico
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0), // Añadir padding horizontal
              child: Text(
                'Optimiza tu\nGanadería con\nBoviSales',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: screenWidth * 0.08, // Tamaño de texto dinámico basado en el ancho de la pantalla
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
