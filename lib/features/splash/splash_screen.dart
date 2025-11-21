import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_const.dart';
import '../../core/routes/app_routes.dart';
import '../../core/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final bool onboardingDone = prefs.getBool(AppConst.onBoarding) ?? false;
    final String? token = await TokenManager.get();

    String nextRoute;

    if (!onboardingDone) {
      nextRoute = AppRoutes.onboardingRoute;
    } else if (token == null || token.isEmpty) {
      nextRoute = AppRoutes.loginRoute;
    } else {
      nextRoute = AppRoutes.mainLayoutRoute;
    }

    Navigator.pushReplacementNamed(context, nextRoute);
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
          Center(
            child: Image.asset(
              'assets/splash_logo/splash1.png',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
