import 'package:budgeting_app/plans/presentation/screens/create_plan_screen.dart';
import 'package:budgeting_app/plans/presentation/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String splashScreen = "/";
  static const String introScreen = "introScreen";
  static const String createPlanScreen = "createPlanScreen";
}

class RoutesManager {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());
      case Routes.introScreen:
        return MaterialPageRoute(builder: (context) => const IntroScreen());
      case Routes.createPlanScreen:
        return MaterialPageRoute(builder: (context) => CreatePlanScreen());
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
