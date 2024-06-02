import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _handleLoginStatus();
  }

  Future<void> _handleLoginStatus() async {
    bool isLoggedIn = await AuthService.isLoggedIn();

    await Future.delayed(const Duration(seconds: 1));

    // Check if the widget is still mounted before performing navigation
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/tasks');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Task',
                style: TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: 'y',
                style: TextStyle(color: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
