import 'package:bovi_sales/presentation/bindings/home_binding.dart';
import 'package:bovi_sales/presentation/pages/add_cow_page.dart';
import 'package:bovi_sales/presentation/pages/bovino_details_page.dart';
import 'package:bovi_sales/presentation/pages/ganado_page.dart';
import 'package:bovi_sales/presentation/pages/home_page.dart';
import 'package:bovi_sales/presentation/pages/publicaciones_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'presentation/bindings/onboarding_binding.dart';
import 'presentation/bindings/signup_binding.dart';
import 'presentation/bindings/login_binding.dart';
import 'presentation/bindings/profile_binding.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/controllers/navigation_controller.dart'; // Importa el controlador

void main() async {
  await GetStorage.init(); // Inicializa GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController()); // Inicializa el NavigationController

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
        // Agrega las rutas principales
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/publicaciones',
          page: () => PublicacionesPage(),
        ),
        GetPage(
          name: '/venta',
          page: () => GanadoPage(),
        ),
        GetPage(
          name: '/add_cow',
          page: () => AddCowPage(),
        ),
        GetPage(name: '/details', page: () => BovinoDetailsPage()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
