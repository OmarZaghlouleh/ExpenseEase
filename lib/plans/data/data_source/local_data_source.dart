// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:developer';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';

import 'package:hive/hive.dart';

abstract class BaseLocalDataSource {
  const BaseLocalDataSource();

  Future<void> createEmployeePlan(
      {required EmployeePlanModel employeePlanModel});
  Future<void> createBusinessPlan(
      {required BusinessPlanModel businessPlanModel});
}

class LocalDataSource extends BaseLocalDataSource {
  @override
  Future<void> createEmployeePlan(
      {required EmployeePlanModel employeePlanModel}) async {
    try {
      final box = Hive.box(AppConstants.plansBox);
      final appData = Hive.box(AppConstants.appDataBox);

      appData.put(AppConstants.lastPlanKey, employeePlanModel.name);

      checkIfNameExist(employeePlanModel.name, box);
      await box.add(employeePlanModel.toJsonFirst());
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.creatingPlanErrorMessage));
    }
  }

  @override
  Future<void> createBusinessPlan(
      {required BusinessPlanModel businessPlanModel}) async {
    try {
      final box = Hive.box(AppConstants.plansBox);
      final appData = Hive.box(AppConstants.appDataBox);
      appData.put(AppConstants.lastPlanKey, businessPlanModel.name);
      checkIfNameExist(businessPlanModel.name, box);
      await box.add(businessPlanModel.toJson());
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.creatingPlanErrorMessage));
    }
  }
}
