import 'dart:developer';

import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/widgets/dialogs/error_dialog.dart';
import 'package:budgeting_app/home/domain/usecases/get_business_plan_details.usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_employee_plan_details_usecase.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  EmployeePlanModel _employeePlanModel = EmployeePlanModel.empty();
  BusinessPlanModel _businessPlanModel = BusinessPlanModel.empty();
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
        setEmployeePlanModel(context: context);
        break;
      case PlanType.business:
        setBusinessPlanModel(context: context);
        break;
      case PlanType.none:
        Navigator.pushReplacementNamed(context, Routes.createPlanScreen);
        break;
    }
  }

  void setEmployeePlanModel({required BuildContext context}) {
    log("Setting employee");
    final result =
        getIt<GetEmployeePlanDetailsUsecase>().call(getLastPlanName());

    result.fold((l) {
      log("Set Employee Error");
      showErrorDialog(context: context, message: l.message);
    }, (data) {
      _employeePlanModel = data;
      log("test" + _employeePlanModel.name.toString());
      notifyListeners();
    });
  }

  void setBusinessPlanModel({required BuildContext context}) {
    log("Setting business");

    final result =
        getIt<GetBusinessPlanDetailsUsecase>().call(getLastPlanName());
    result.fold((l) {
      log("Set Business Error");

      showErrorDialog(context: context, message: l.message);
    }, (data) {
      _businessPlanModel = data;
      notifyListeners();
    });
  }

  EmployeePlanModel get getEmployeePlanModel => _employeePlanModel;
  BusinessPlanModel get getBusinessPlanModel => _businessPlanModel;
  PlanType get getPlanType => _planType;
}
