import 'package:bovi_sales/presentation/bindings/onboarding_binding.dart';
import 'package:bovi_sales/presentation/bindings/signup_binding.dart';
import 'package:bovi_sales/presentation/pages/onboarding_page.dart';
import 'package:bovi_sales/presentation/pages/signup_page.dart';
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
          binding: OnboardingBinding(), // Aunque no hace nada ahora, está preparado para el futuro.
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
          binding: SignupBinding(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
