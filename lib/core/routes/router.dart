import 'package:challenge_direct_solution/features/auth/presentation/pages/login_page.dart';
import 'package:challenge_direct_solution/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage());

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
