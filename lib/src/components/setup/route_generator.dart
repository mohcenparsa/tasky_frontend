import 'package:flutter/material.dart';
import 'package:tasky/src/pages/create_task_page.dart';
import 'package:tasky/src/pages/login_page.dart';
import 'package:tasky/src/pages/profile_page.dart';
import 'package:tasky/src/pages/register_page.dart';
import 'package:tasky/src/pages/tasks_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case '/tasks':
        return MaterialPageRoute(builder: (_) => const TaskListPage());
      case '/tasks/create':
        return MaterialPageRoute(builder: (_) => const CreateTaskPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
