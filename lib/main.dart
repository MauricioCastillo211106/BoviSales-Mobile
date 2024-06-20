// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/bindings/login_binding.dart';
import 'package:bovi_sales/presentation/bindings/profile_binding.dart';
import 'package:bovi_sales/presentation/pages/login_page.dart';
import 'presentation/bindings/onboarding_binding.dart';
import 'presentation/bindings/signup_binding.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/ganado_page.dart';
import 'presentation/pages/publicaciones_page.dart';

void main() async {
  await GetStorage.init(); // Inicializa GetStorage
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
          page: () => LoginPage(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/publicaciones',
          page: () => PublicacionesPage(),
        ),
        GetPage(
          name: '/ganado',
          page: () => GanadoPage(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
