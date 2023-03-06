import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/domain/usecases/create_business_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/create_employee_plan_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreatePlanProvider extends ChangeNotifier {
  PlanType? _planType;
  CurrencyType _currencyType = CurrencyType.dollar;
  bool _isLoading = false;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void setPlanType(PlanType planType) {
    _planType = planType;
    notifyListeners();
  }

  void setCurrencyType(int i) {
    _currencyType = i == 0 ? CurrencyType.dollar : CurrencyType.syrianPound;
  }

  Future<void> createPlan(
      {required String name, required String salary}) async {
    toggleLoading();
    Either<Failure, void>? result;
    if (getPlanType == PlanType.employee) {
      result = await getIt<CreateEmployeePlanUsecase>().call(EmployeePlanModel(
          name: name,
          salary: double.tryParse(salary) ?? 0,
          currencyType: getCurrencyType,
          type: PlanType.employee));
    } else if (getPlanType == PlanType.business) {
      result = await getIt<CreateBusinessPlanUsecase>().call(BusinessPlanModel(
          name: name,
          currencyType: getCurrencyType,
          planType: PlanType.business));
    }
    toggleLoading();

    if (result != null) {
      result.fold((l) {}, (r) {});
    }
  }

  bool canMove(int page) {
    switch (page) {
      case 0:
        if (_planType != null) return true;
        return false;
      default:
        return false;
    }
  }

  PlanType get getPlanType => _planType ?? PlanType.none;
  CurrencyType get getCurrencyType => _currencyType;
  bool get getLoadingSta => _isLoading;
}
