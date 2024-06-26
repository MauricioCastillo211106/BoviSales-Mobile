import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'presentation/bindings/initial_bindings.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';
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
          binding: InitialBindings(),
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
          name: '/publicaciones',
          page: () => PublicacionesPage(),
        ),
        GetPage(
          name: '/venta',
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
