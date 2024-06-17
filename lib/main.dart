import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/pages/onboarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BoviSales Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Sora', // Establece Sora como la fuente predeterminada
      ),
      home: OnboardingPage(),
    );
  }
}
