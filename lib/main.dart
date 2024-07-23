// lib/main.dart
import 'package:bovi_sales/presentation/bindings/publicaciones_binding.dart';
import 'package:bovi_sales/presentation/bindings/ventas_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'presentation/bindings/navigation_binding.dart';
import 'presentation/pages/bovino_details_page.dart';
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
import 'presentation/pages/premium_page.dart';
import 'presentation/pages/webview_page.dart';
import 'presentation/pages/edit_bovino_page.dart';
import 'presentation/pages/ventas_page.dart';
import 'presentation/bindings/edit_bovino_binding.dart';

void main() async {
  await GetStorage.init(); // Inicializa GetStorage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BoviSales',
      debugShowCheckedModeBanner: false,
      initialBinding: NavigationBinding(),
      initialRoute: storage.read('user') != null ? '/home' : '/',
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
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/publicaciones',
          page: () => PublicacionesPage(),
          binding: PublicacionesBinding(),
        ),
        GetPage(
          name: '/venta',
          page: () => VentaPage(),
          binding: VentasBinding(),
        ),
        GetPage(
          name: '/add_cow',
          page: () => AddCowPage(),
        ),
        GetPage(
          name: '/bovino_details',
          page: () => BovinoDetailsPage(bovino: Bovino(name: '', breed: '', earringNumber: 0, age: 0, gender: '', weight: '', id: '')),
        ),
        GetPage(
          name: '/premium',
          page: () => PremiumPage(),
          binding: PremiumBinding(),
        ),
        GetPage(
          name: '/webview',
          page: () => WebViewPage(url: ''),
        ),
        GetPage(
          name: '/edit_bovino',
          page: () => EditBovinoPage(bovino: Bovino(name: '', breed: '', earringNumber: 0, age: 0, gender: '', weight: '', id: '')),
          binding: EditBovinoBinding(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Sora',
      ),
    );
  }
}
