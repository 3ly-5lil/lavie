import 'package:flutter/material.dart';
import 'package:lavie/ui/screens/home_screen.dart';
import 'package:lavie/ui/screens/welcome_screens/auth_screen.dart';
import 'package:lavie/ui/screens/welcome_screens/splash_screen.dart';

import '../ui/screens/welcome_screens/claim_seed_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/log':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/claimSeed':
        return MaterialPageRoute(builder: (_) => ClaimSeedScreen());
      default:
        return null;
    }
  }
}
