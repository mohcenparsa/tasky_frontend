import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/src/pages/onboarding_page.dart'; // Ensure this is imported
import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _handleLoginStatus();
  }

  Future<void> _handleLoginStatus() async {
    bool isLoggedIn = await _authService.isLoggedIn();
    bool hasSeenOnboarding = await _hasSeenOnboarding();
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/tasks');
    } else if (!hasSeenOnboarding) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<bool> _hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenOnboarding') ?? false;
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
