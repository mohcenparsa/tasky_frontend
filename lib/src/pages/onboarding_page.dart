import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacementNamed(context, '/tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/task_art.png'), // Replace with your image
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the App!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This is a brief description of your app and its functionalities.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => _completeOnboarding(context),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
