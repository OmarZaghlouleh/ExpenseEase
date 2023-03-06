import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/utils/themes/light_theme.dart';
import 'package:budgeting_app/plans/presentation/controller/create_plan_provider.dart';
import 'package:budgeting_app/plans/presentation/controller/intro_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

void main() async {
  await ServiceLocator.init();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.plansBox);
  await Hive.box(AppConstants.plansBox).clear();
  runApp(const BudgetingApp());
}

class BudgetingApp extends StatelessWidget {
  const BudgetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntroProvider()),
        ChangeNotifierProvider(create: (context) => CreatePlanProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: RoutesManager.getRoute,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: getLightTheme(),
      ),
    );
  }
}
