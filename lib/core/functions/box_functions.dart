// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:developer';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:hive/hive.dart';

void checkIfNameExist(String name, Box box) async {
  for (int i = 0; i < box.values.length; i++) {
    if (jsonDecode(box.values.toList()[i].toString())['name'] == name)
      throw LocalException(
          errorModel:
              ErrorModel(message: AppStrings.getMatchedNameErrorMessage(name)));
  }
}

PlanType getLastPlanType() {
  final box = Hive.box(AppConstants.plansBox);
  for (int i = 0; i < box.values.length; i++) {
    if (jsonDecode(box.values.toList()[i].toString())['name'] ==
        getLastPlanName()) {
      if (jsonDecode(box.values.toList()[i])['type'].toString() ==
          PlanType.business.name)
        return PlanType.business;
      else
        return PlanType.employee;
    }
  }

  return PlanType.none;
}

String getLastPlanName() {
  final appData = Hive.box(AppConstants.appDataBox);
  if (appData.get(AppConstants.lastPlanKey) != null)
    return appData.get(AppConstants.lastPlanKey);
  return AppStrings.emptyString;
}
