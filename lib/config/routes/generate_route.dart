import 'package:film/config/routes/app_routes.dart';
import 'package:film/features/main/pages/main_sccreen.dart';
import 'package:film/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:film/testing_page.dart';
import 'package:flutter/material.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnboardingScreen(),
        );

      case AppRoutes.testingPage:
        return MaterialPageRoute(
          builder: (_) => const TestingPage(),
        );
      case AppRoutes.mainScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
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
