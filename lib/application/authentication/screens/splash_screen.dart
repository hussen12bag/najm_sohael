import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/application/Admin/admingome.dart';
import 'package:flutter_application_2/application/dashboard/screens/dashboard_tab.dart';
import 'package:flutter_application_2/application/home/screens/home_screen.dart';
import 'package:flutter_application_2/main.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => role == null
                ? LoginScreen()
                : role == "user"
                    ? HomeScreen()
                    : AdminHome(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/logo.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
