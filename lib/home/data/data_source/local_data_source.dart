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
    try {
      BusinessPlanModel businessPlanModel = BusinessPlanModel.empty();
      final plansDetailsBox = Hive.box(AppConstants.plansBox);

      plansDetailsBox.toMap().entries.forEach((element) {
        if (element.value['name'] == planName &&
            element.value['type'] == PlanType.business.name) {
          businessPlanModel = BusinessPlanModel.fromJson(element.value);
        }
      });

      return businessPlanModel;
    } catch (e) {
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.gettingPlanErrorMessage));
    }
  }

  @override
  EmployeePlanModel getEmployeePlanDetails({required String planName}) {
    try {
      EmployeePlanModel employeePlanModel = EmployeePlanModel.empty();
      final plansDetailsBox = Hive.box(AppConstants.plansBox);

      plansDetailsBox.toMap().entries.forEach((element) {
        if (element.value['name'] == planName &&
            element.value['type'] == PlanType.employee.name) {
          employeePlanModel = EmployeePlanModel.fromJson(element.value);
        }
      });

      return employeePlanModel;
    } catch (e) {
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.gettingPlanErrorMessage));
    }
  }
}
