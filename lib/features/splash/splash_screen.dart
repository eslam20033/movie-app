import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Image.asset(
                      'assets/splash_logo/splash2.png',
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Image.asset(
                    'assets/splash_logo/splash3.png',
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          Center(child: Image.asset('assets/splash_logo/splash1.png', width: 150, height: 150)),
        ],
      ),
    );
  }
}
