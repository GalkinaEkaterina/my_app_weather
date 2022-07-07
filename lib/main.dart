import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:my_app_weather/main_screen/main_screen_model.dart';

import 'package:my_app_weather/main_screen/mainscreenwidget.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ChangeNotifierProvider(
          child: const MainScreenWidget(),//ВИДЖЕТЫ ГЛАВНОГО ЭКРАНА
          create: (_) => MainScreenModel(),// МОДЕЛЬ ГЛАВНОГО ЭКРАНА
          lazy: false,
        ),
      ),
    );
  }
}
