import 'package:bovi_sales/presentation/bindings/onboarding_binding.dart';
import 'package:bovi_sales/presentation/bindings/signup_binding.dart';
import 'package:bovi_sales/presentation/pages/login_page.dart';
import 'package:bovi_sales/presentation/pages/onboarding_page.dart';
import 'package:bovi_sales/presentation/pages/signup_page.dart';
import 'package:bovi_sales/presentation/pages/login_page.dart'; // Importa la página de inicio de sesión
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BoviSales',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => OnboardingPage(),
          binding: OnboardingBinding(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
          binding: SignupBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(), // Define la página de inicio de sesión
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
