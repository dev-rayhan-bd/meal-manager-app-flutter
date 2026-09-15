import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/screens/main_navigation_screen.dart';

/// Centralized Routing Manager for clean navigation.
class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
