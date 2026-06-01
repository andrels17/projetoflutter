import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.navyDark,
              AppColors.navy,
              Color(0xFF0B397C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 138,
                    height: 138,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    child: Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 82,
                    ),
                  ),
                  const Positioned(
                    bottom: 32,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 58,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 38),
              const Text(
                'EduCheck',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sua rotina acadêmica sob controle',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 46),
              const SizedBox(
                width: 34,
                height: 34,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                  backgroundColor: Color(0x335CA0E6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
