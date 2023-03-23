import 'dart:developer';

import 'package:budgeting_app/classes/percent.dart';
import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/widgets/dialogs/error_dialog.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_employee_plan_details_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_expenses_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/get_folders_usecase.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/domain/entities/employee_plan_entity.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeePlanEntity _employeePlanModel = EmployeePlanModel.empty();
  Percent _percent = Percent.empty();
  List<ExpenseEntity> _expenses = [];
  List<ExpensesFolderEntity> _folders = [];
  bool _isGettingExpenses = false;
  bool _isGettingFolders = false;
  bool _isFloatingActionButtonOpened = false;
  bool _isDragging = false;
  bool _isFileVisible = false;

  void triggerFileVisibility({required PageController pageController}) {
    _isFileVisible = !_isFileVisible;
    if (pageController.page == pageController.initialPage) {
      pageController.nextPage(
          duration: const Duration(milliseconds: AnimationDuration.d500),
          curve: Curves.linear);
    } else {
      pageController.previousPage(
          duration: const Duration(milliseconds: AnimationDuration.d500),
          curve: Curves.linear);
    }
    notifyListeners();
  }

  void setDraggingState({required bool state}) {
    log(state.toString());
    _isDragging = state;
    notifyListeners();
  }

  void triggerFloatingActionButtonState() {
    _isFloatingActionButtonOpened = !_isFloatingActionButtonOpened;
    notifyListeners();
  }

  void setGettingFoldersState({required bool value}) {
    _isGettingFolders = value;
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
      getExpensesModels(context: context);
      getFoldersModels(context: context);

      //No need to notify because setPercent function already have it!
    });
  }

  Future<void> addFolder(
      {required String name, required BuildContext context}) async {
    final result = await getIt<AddExpensesFolderUsecase>().call(
        AddExpesnesFolderUsecaseParameters(
            name: name, planName: getEmployeePlanModel.name, expenses: []));

    result.fold((l) {
      showErrorDialog(context: context, message: l.message);
    }, (r) {
      _folders.add(r);
      notifyListeners();
    });
  }

  void getFoldersModels({required BuildContext context}) {
    setGettingExpensesState(value: true);
    getIt<GetExpensesFolderUsecase>().call(getEmployeePlanModel.name).fold((l) {
      showErrorDialog(context: context, message: l.message);
    }, (r) => _folders = r);
    setGettingExpensesState(value: false);
  }

  void getExpensesModels({required BuildContext context}) {
    setGettingExpensesState(value: true);
    getIt<GetExpensesUsecase>().call(getEmployeePlanModel.name).fold((l) {
      showErrorDialog(context: context, message: l.message);
    }, (r) => _expenses = r);
    setGettingExpensesState(value: false);
  }

  Future<void> addToExpenses(
      {required String name,
      required double value,
      required BuildContext context}) async {
    final result = await getIt<AddToExpenseUsecase>().call(
        AddToExpenseParameters(
            name: name, value: value, planNmae: getEmployeePlanModel.name));

    result.fold((l) {
      showErrorDialog(context: context, message: l.message);
    }, (r) {
      _expenses.add(r);
      notifyListeners();
    });
  }

  EmployeePlanEntity get getEmployeePlanModel => _employeePlanModel;
  Percent get getPercent => _percent;
  List<ExpenseEntity> get getExpenses => _expenses;
  List<ExpensesFolderEntity> get getFolders => _folders;

  bool get getGettingExpensesState => _isGettingExpenses;
  bool get getGettingFoldersState => _isGettingFolders;
  bool get getFloatingActionButtonState => _isFloatingActionButtonOpened;
  bool get getDraggingState => _isDragging;
  bool get getFileVisibility => _isFileVisible;
}
