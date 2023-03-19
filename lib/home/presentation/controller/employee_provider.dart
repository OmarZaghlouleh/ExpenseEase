import 'dart:developer';

import 'package:budgeting_app/classes/percent.dart';
import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/widgets/dialogs/error_dialog.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/usecases/get_employee_plan_details_usecase.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeePlanModel _employeePlanModel = EmployeePlanModel.empty();
  Percent _percent = Percent.empty();
  List<ExpenseModel> _expenses = [];
  bool _isGettingExpenses = false;
  bool _isFloatingActionButtonOpened = false;

  void triggerFloatingActionButtonState() {
    _isFloatingActionButtonOpened = !_isFloatingActionButtonOpened;
    notifyListeners();
  }

  void setGettingExpensesState({required bool value}) {
    _isGettingExpenses = value;
    notifyListeners();
  }

  void setPercent() {
    double decimal = getPercentInDecimal(
        total: _employeePlanModel.salary,
        current: _employeePlanModel.currentBalance);
    int percentage = getPercentInHundred(
        total: _employeePlanModel.salary,
        current: _employeePlanModel.currentBalance);
    _percent = Percent(decimal: decimal, percentage: percentage);
    notifyListeners();
  }

  void setEmployeePlanModel({required BuildContext context}) {
    final result =
        getIt<GetEmployeePlanDetailsUsecase>().call(getLastPlanName());

    result.fold((l) {
      showErrorDialog(context: context, message: l.message);
    }, (data) {
      _employeePlanModel = data;

      setPercent();
      setExpenses();

      //No need to notify because setPercent function already have it!
    });
  }

  void setExpenses() {
    final box = Hive.box(AppConstants.expensesBox);
    setGettingExpensesState(value: true);

    if (box.containsKey(getEmployeePlanModel.name)) {
      List data = box
          .toMap()
          .entries
          .firstWhere(
              (element) => element.key.toString() == getEmployeePlanModel.name)
          .value as List;
      for (var element in data) {
        _expenses.add(ExpenseModel.fromJson(element));
      }
    }
    setGettingExpensesState(value: false);
  }

  Future<void> addToExpenses(
      {required String name, required double value}) async {
    final box = Hive.box(AppConstants.expensesBox);
    List data = [];
    if (box.containsKey(getEmployeePlanModel.name)) {
      data = box
          .toMap()
          .entries
          .firstWhere(
              (element) => element.key.toString() == getEmployeePlanModel.name)
          .value as List;
    }

    ExpenseModel expenseModel = ExpenseModel(name: name, paid: value);
    data.add(expenseModel.toJson());
    box.delete(getEmployeePlanModel.name);
    await box.put(getEmployeePlanModel.name, data);

    _expenses.add(expenseModel);
    notifyListeners();
  }

  EmployeePlanModel get getEmployeePlanModel => _employeePlanModel;
  Percent get getPercent => _percent;
  List<ExpenseModel> get getExpenses => _expenses;
  bool get getGettingExpensesState => _isGettingExpenses;
  bool get getFloatingActionButtonState => _isFloatingActionButtonOpened;
}
