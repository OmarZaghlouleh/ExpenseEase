import 'dart:developer';

import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/home/presentation/controller/business_provider.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  PlanType _planType = PlanType.none;

  void setPlanType({required PlanType planType}) {
    _planType = planType;
    notifyListeners();
  }

  void initPlan({required BuildContext context}) {
    _planType = getLastPlanType();
    log("$_planType");
    log(_planType.name);
    switch (getPlanType) {
      case PlanType.employee:
        Provider.of<EmployeeProvider>(context, listen: false)
            .setEmployeePlanModel(context: context);
        notifyListeners();
        break;
      case PlanType.business:
        Provider.of<BusinessProvider>(context, listen: false)
            .setBusinessPlanModel(context: context);
        notifyListeners();
        break;
      case PlanType.none:
        Navigator.pushReplacementNamed(context, Routes.createPlanScreen);
        break;
    }
  }

  PlanType get getPlanType => _planType;
}
