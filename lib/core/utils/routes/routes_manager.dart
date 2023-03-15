import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:budgeting_app/home/presentation/screens/home_screen.dart';
import 'package:budgeting_app/plans/presentation/screens/create_plan_screen.dart';
import 'package:budgeting_app/plans/presentation/screens/intro_screen.dart';
import 'package:budgeting_app/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static const String splashScreen = "/";
  static const String introScreen = "introScreen";
  static const String createPlanScreen = "createPlanScreen";
  static const String homeScreen = "homeScreen";
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        ServiceLocator.initPlan();
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.introScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());
      case Routes.createPlanScreen:
        return MaterialPageRoute(builder: (context) => CreatePlanScreen());
      case Routes.homeScreen:
        ServiceLocator.initHome();
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      default:
        return MaterialPageRoute(builder: (context) => const UndefinedRoute());
    }
  }
}

class UndefinedRoute extends StatelessWidget {
  const UndefinedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
