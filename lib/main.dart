import 'package:e_voting/view/auth/login/login_screen.dart';
import 'package:e_voting/view/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black54),
        titleLarge: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    home: BottomNavScreen(),
  ));
}
