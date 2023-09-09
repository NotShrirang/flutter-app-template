import 'package:dermacare_ai/screen/HomePage/homePage.dart';
import 'package:dermacare_ai/screen/UserOnboarding/loginPage.dart';
import 'package:dermacare_ai/screen/UserOnboarding/userOnboardingPage.dart';
import 'package:dermacare_ai/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DevFinder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Root(),
      routes: {
        '/home': (context) => const HomePage(title: 'DevFinder'),
        '/login': (context) => const LoginPage(),
        '/userOnboarding': (context) => const UserOnboardingPage(),
      },
    );
  }
}
