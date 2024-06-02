import 'package:flutter/material.dart';
import 'package:tasky/src/services/auth_service.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize:
          MainAxisSize.min, // Avoids excessive space on smaller screens
      children: [
        IconButton(
          icon: const Icon(Icons.person),
          color: Colors.purple, // Set the desired purple color here

          onPressed: () {
            // Navigate to profile
            Navigator.pushNamed(
                context, '/profile'); // Replace with your navigation logic
          },
        ),
        IconButton(
            color: Colors.purple, // Set the desired purple color here

            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout(); // Call the logout service
              Navigator.pushNamed(context, '/login');
            }),
      ],
    );
  }
}
