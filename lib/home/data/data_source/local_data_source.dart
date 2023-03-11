import 'dart:convert';
import 'dart:developer';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';

import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:hive/hive.dart';

abstract class BaseHomeLocalDataSource {
  EmployeePlanModel getEmployeePlanDetails({required String planName});
  BusinessPlanModel getBusinessPlanDetails({required String planName});
}

class HomeLocalDataSource extends BaseHomeLocalDataSource {
  @override
  BusinessPlanModel getBusinessPlanDetails({required String planName}) {
    log("settingggg");
    try {
      BusinessPlanModel businessPlanModel = BusinessPlanModel.empty();
      final plansDetailsBox = Hive.box(AppConstants.plansBox);

      for (int i = 0; i < plansDetailsBox.toMap().entries.length; i++) {
        if (jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                    'name'] ==
                planName &&
            jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                    'type'] ==
                PlanType.business.name) {
          businessPlanModel = BusinessPlanModel.fromJson(
              jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value));
          break;
        }
      }

      log(businessPlanModel.name);
      return businessPlanModel;
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.gettingPlanErrorMessage));
    }
  }

  @override
  EmployeePlanModel getEmployeePlanDetails({required String planName}) {
    try {
      log("Plan: $planName");
      EmployeePlanModel employeePlanModel = EmployeePlanModel.empty();
      final plansDetailsBox = Hive.box(AppConstants.plansBox);
      log(plansDetailsBox.toMap().entries.toString());
      for (int i = 0; i < plansDetailsBox.toMap().entries.length; i++) {
        if (jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                        "name"]
                    .toString() ==
                planName &&
            jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                        "type"]
                    .toString() ==
                PlanType.employee.name) {
          log("setttt");
          employeePlanModel = EmployeePlanModel.fromJson(
              jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value));
          break;
        }
      }

      log("tttt ${employeePlanModel.name}");

      return employeePlanModel;
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.gettingPlanErrorMessage));
    }
  }
}
