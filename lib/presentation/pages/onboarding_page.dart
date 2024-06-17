import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, -300), // Ajuste para mover la imagen de forma precisa
              child: Image.asset(
                'assets/images/BoviSales(Onboarding).jpg', // Ruta correcta a tu imagen
                fit: BoxFit.cover, // Asegurarse de que la imagen cubra toda la pantalla
                alignment: Alignment.center, // Alinear la imagen para centrado más preciso
              ),
            ),
          ),
          // Contenedor inferior con degradado
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
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
                  SizedBox(height: 20), // Espacio para el texto principal
                  Text(
                    'Gestiona y comercializa eficazmente tu ganado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Crear cuenta pulsado');
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Texto para "Iniciar Sesión"
                  TextButton(
                    onPressed: () {
                      print('Iniciar Sesión pulsado');
                      // Navegar a la página de inicio de sesión, si es necesario
                    },
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 16,
                        color: Color(0xFFC67C4E), // Aplicar el color especificado
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Texto principal sobre la imagen, pero antes del contenedor degradado
          Positioned(
            top: MediaQuery.of(context).size.height * 0.56, // Ajustar la posición vertical
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Añadir padding horizontal
              child: Text(
                'Optimiza tu\nGanadería con\nBoviSales',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.w600, // SemiBold
                  fontSize: 32, // Tamaño 32
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
