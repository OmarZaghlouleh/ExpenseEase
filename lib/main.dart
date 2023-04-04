import 'dart:developer';

import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/utils/themes/light_theme.dart';
import 'package:budgeting_app/home/presentation/controller/business_provider.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:budgeting_app/plans/presentation/controller/create_plan_provider.dart';
import 'package:budgeting_app/plans/presentation/controller/intro_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

void main() async {
  await ServiceLocator.init();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.plansBox);
  await Hive.openBox(AppConstants.appDataBox);
  await Hive.openBox(AppConstants.expensesBox);
  await Hive.openBox(AppConstants.incomesBox);
  await Hive.openBox(AppConstants.foldersBox);
  //await Hive.box(AppConstants.foldersBox).clear();
  log(Hive.box(AppConstants.expensesBox).toMap().toString());

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
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
        ChangeNotifierProvider(create: (context) => BusinessProvider()),
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
