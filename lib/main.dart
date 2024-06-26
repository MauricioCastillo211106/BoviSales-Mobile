// lib/main.dart
import 'package:bovi_sales/presentation/bindings/initial_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';
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
      initialBinding: InitialBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => OnboardingPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/ganado',
          page: () => GanadoPage(),
        ),
        GetPage(
          name: '/publicaciones',
          page: () => PublicacionesPage(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
