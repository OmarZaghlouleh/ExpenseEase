// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/widgets/dialogs/error_dialog.dart';
import 'package:budgeting_app/core/widgets/dialogs/loading_dialog.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/domain/usecases/create_business_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/create_employee_plan_usecase.dart';
import 'package:budgeting_app/plans/domain/usecases/set_created_plan_status_usecase.dart';
import 'package:dartz/dartz.dart';
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
    notifyListeners();
  }

  Future<void> createPlan(
      {required String name,
      required String salary,
      required BuildContext context}) async {
    toggleLoading();
    Either<Failure, void>? result;
    if (getPlanType == PlanType.employee) {
      result = await getIt<CreateEmployeePlanUsecase>().call(EmployeePlanModel(
        name: name,
        currencyType: getCurrencyType,
        currentBalance: 0,
        incomes: const [],
        expenses: const [],
        type: PlanType.business,
        salary: double.tryParse(salary) ?? 0,
      ));
    } else if (getPlanType == PlanType.business) {
      result = await getIt<CreateBusinessPlanUsecase>().call(BusinessPlanModel(
        name: name,
        currencyType: getCurrencyType,
        planType: PlanType.business,
        currentBalance: 0,
        incomes: const [],
        expenses: const [],
      ));
    }
    toggleLoading();
    //pop loading dialog
    Navigator.pop(context);
    if (result != null) {
      result.fold((l) {
        log("Error");
        showErrorDialog(context: context, message: l.message);
      }, (r) async {
        await getIt<SetCreatedPlanStatus>().call(true);
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      });
    }
  }

  Future<void> nextFunction({
    required PageController pageController,
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController salaryController,
  }) async {
    if (pageController.offset == pageController.position.maxScrollExtent) {
      final result = formKey.currentState!.validate();
      if (result == true) {
        showLoadingDialog(context: context);
        await createPlan(
          name: nameController.text.trim(),
          salary: salaryController.text.trim(),
          context: context,
        );
      }
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: AnimationDuration.d300),
        curve: Curves.linear,
      );
    }
  }

  bool canMove(int page) {
    switch (page) {
      case 0:
        return _planType != null;
      default:
        return false;
    }
  }

  PlanType get getPlanType => _planType ?? PlanType.none;
  CurrencyType get getCurrencyType => _currencyType;
  bool get getLoadingSta => _isLoading;
}
