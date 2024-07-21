import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bovi_sales/presentation/pages/bovino_details_page.dart';
import 'core/models/bovino_model.dart';
import 'presentation/bindings/onboarding_binding.dart';
import 'presentation/bindings/signup_binding.dart';
import 'presentation/bindings/login_binding.dart';
import 'presentation/bindings/profile_binding.dart';
import 'presentation/bindings/home_binding.dart';
import 'presentation/bindings/premium_binding.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/profile_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/add_cow_page.dart';
import 'presentation/pages/publicaciones_page.dart';
import 'presentation/pages/ganado_page.dart';
import 'presentation/pages/premium_page.dart';
import 'presentation/controllers/navigation_controller.dart';
import 'presentation/pages/webview_page.dart';

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
        GetPage(
          name: '/bovino_details',
          page: () => BovinoDetailsPage(bovino: Bovino(name: '', breed: '', earringNumber: 0, age: 0, gender: '', weight: '')),
        ),
        GetPage(
          name: '/premium',
          page: () => PremiumPage(),
          binding: PremiumBinding(),
        ),
        GetPage(
          name: '/webview',
          page: () => WebViewPage(url: 'https://flutter.dev'),// URL se pasará a través de Get.to()
        ),
      ],

      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
