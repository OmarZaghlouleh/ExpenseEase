import 'dart:convert';
import 'dart:developer';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';

import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:hive/hive.dart';

abstract class BaseHomeLocalDataSource {
  EmployeePlanModel getEmployeePlanDetails({required String planName});
  BusinessPlanModel getBusinessPlanDetails({required String planName});
  List<ExpenseModel> getExpesnes({required String planName});
  Future<ExpenseModel> addToExpense(
      {required AddToExpenseParameters addToExpenseParameters});

  Future<ExpensesFolderModel> addExpensesFolder(
      {required AddExpesnesFolderUsecaseParameters addFolderUsecaseParameters});
  List<ExpensesFolderModel> getExpensesFolders({required String planName});
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

  @override
  List<ExpenseModel> getExpesnes({required String planName}) {
    try {
      final box = Hive.box(AppConstants.expensesBox);
      List<ExpenseModel> expenses = [];
      if (box.containsKey(planName)) {
        List data = box
            .toMap()
            .entries
            .firstWhere((element) => element.key.toString() == planName)
            .value as List;
        for (var element in data) {
          expenses.add(ExpenseModel.fromJson(element));
        }
      }
      return expenses;
    } catch (e) {
      throw LocalException(
        errorModel:
            const ErrorModel(message: AppStrings.gettingExpesnesErrorMessage),
      );
    }
  }

  @override
  Future<ExpenseModel> addToExpense(
      {required AddToExpenseParameters addToExpenseParameters}) async {
    try {
      final box = Hive.box(AppConstants.expensesBox);
      List data = [];

      if (box.containsKey(addToExpenseParameters.planNmae)) {
        data = box
            .toMap()
            .entries
            .firstWhere((element) =>
                element.key.toString() == addToExpenseParameters.planNmae)
            .value as List;
      }

      ExpenseModel expenseModel = ExpenseModel(
          name: addToExpenseParameters.name,
          paid: addToExpenseParameters.value);
      data.add(expenseModel.toJson());
      box.delete(addToExpenseParameters.planNmae);
      await box.put(addToExpenseParameters.planNmae, data);

      return expenseModel;
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.addExpenseErrorMessage));
    }
  }

  @override
  Future<ExpensesFolderModel> addExpensesFolder(
      {required AddExpesnesFolderUsecaseParameters
          addFolderUsecaseParameters}) async {
    try {
      final box = Hive.box(AppConstants.foldersBox);
      List data = [];
      if (box.containsKey(addFolderUsecaseParameters.planName)) {
        data = box
            .toMap()
            .entries
            .firstWhere((element) =>
                element.key.toString() == addFolderUsecaseParameters.planName)
            .value as List;
      }

      ExpensesFolderModel folderModel = ExpensesFolderModel(
          name: addFolderUsecaseParameters.name,
          expenses: addFolderUsecaseParameters.expenses);
      data.add(folderModel.toJson());
      box.delete(addFolderUsecaseParameters.planName);
      await box.put(addFolderUsecaseParameters.planName, data);

      return folderModel;
    } catch (e) {
      log(e.toString());
      throw LocalException(
          errorModel:
              const ErrorModel(message: AppStrings.addFolderErrorMessage));
    }
  }

  @override
  List<ExpensesFolderModel> getExpensesFolders({required String planName}) {
    try {
      final box = Hive.box(AppConstants.foldersBox);
      List<ExpensesFolderModel> folders = [];
      log(box.toMap().toString());
      if (box.containsKey(planName)) {
        List data = box
            .toMap()
            .entries
            .firstWhere((element) => element.key.toString() == planName)
            .value as List;
        for (var element in data) {
          folders.add(ExpensesFolderModel.fromJson(element));
        }
      }
      return folders;
    } catch (e) {
      log(e.toString());
      throw LocalException(
        errorModel:
            const ErrorModel(message: AppStrings.gettingFoldersErrorMessage),
      );
    }
  }
}
