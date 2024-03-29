import 'dart:convert';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/functions/debug_log.dart';
import 'package:budgeting_app/core/functions/hive_map.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:budgeting_app/home/domain/usecases/add_expense_to_folder.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_expense_from_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_folder_usecase.dart';

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
  Future<ExpensesFolderModel> addExpenseToFolder(
      {required AddExpenseToFolderParameters addExpenseToFolderParameters});

  Future<void> deleteExpense(
      {required DeleteExpenseUsecaseParameters deleteExpenseUsecaseParameters});
  Future<void> removeExpenseFromFolder(
      {required RemoveExpenseFromFolderUsecaseParameters
          removeExpenseFromFolderUsecaseParameters});

  Future<ExpenseModel> editExpense(
      {required EditExpenseUsecaseParameters editExpenseUsecaseParameters});

  Future<void> deleteFolder(
      {required DeleteFolderUsecaseParameters deleteFolderUsecaseParameters});
  Future<ExpensesFolderModel> editFolder(
      {required EditFolderUsecaseParameters editFolderUsecaseParameters});
}

class HomeLocalDataSource extends BaseHomeLocalDataSource {
  @override
  BusinessPlanModel getBusinessPlanDetails({required String planName}) {
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

      return businessPlanModel;
    } catch (e) {
      debugLog(message: e.toString());

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
      for (int i = 0; i < plansDetailsBox.toMap().entries.length; i++) {
        if (jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                        "name"]
                    .toString() ==
                planName &&
            jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value)[
                        "type"]
                    .toString() ==
                PlanType.employee.name) {
          employeePlanModel = EmployeePlanModel.fromJson(
              jsonDecode(plansDetailsBox.toMap().entries.toList()[i].value));
          break;
        }
      }

      return employeePlanModel;
    } catch (e) {
      debugLog(message: e.toString());

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
      debugLog(message: e.toString());

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
      for (int i = 0; i < data.length; i++) {
        if (ExpenseModel.fromJson(data[i]).name ==
            addToExpenseParameters.name) {
          throw LocalException(
            errorModel: ErrorModel(
              message: AppStrings.isAlreadyExistErrorMessage(
                  name: addToExpenseParameters.name),
            ),
          );
        }
      }
      data.add(expenseModel.toJson());
      box.delete(addToExpenseParameters.planNmae);
      await box.put(addToExpenseParameters.planNmae, data);

      return expenseModel;
    } catch (e) {
      debugLog(message: e.toString());

      throw LocalException(
          errorModel: ErrorModel(
              message: e.runtimeType == LocalException
                  ? (e as LocalException).errorModel.message
                  : AppStrings.addExpenseErrorMessage));
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

      for (int i = 0; i < data.length; i++) {
        if (ExpensesFolderModel.fromJson(data[i]).name ==
            addFolderUsecaseParameters.name) {
          throw LocalException(
            errorModel: ErrorModel(
              message: AppStrings.isAlreadyExistErrorMessage(
                  name: addFolderUsecaseParameters.name),
            ),
          );
        }
      }
      data.add(folderModel.toJson());
      await box.delete(addFolderUsecaseParameters.planName);
      await box.put(addFolderUsecaseParameters.planName, data);

      return folderModel;
    } catch (e) {
      debugLog(message: e.toString());
      if (e is LocalException) rethrow;

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
      debugLog(message: e.toString());

      throw LocalException(
        errorModel:
            const ErrorModel(message: AppStrings.gettingFoldersErrorMessage),
      );
    }
  }

  @override
  Future<ExpensesFolderModel> addExpenseToFolder(
      {required AddExpenseToFolderParameters
          addExpenseToFolderParameters}) async {
    try {
      final box = Hive.box(AppConstants.foldersBox);
      List data = [];
      if (box.containsKey(addExpenseToFolderParameters.planName)) {
        data = box
            .toMap()
            .entries
            .firstWhere((element) =>
                element.key.toString() == addExpenseToFolderParameters.planName)
            .value as List;

        for (var element in data) {
          ExpensesFolderModel folder = ExpensesFolderModel.fromJson(element);

          if (folder.name == addExpenseToFolderParameters.folderName) {
            if (folder.expenses
                    .contains(addExpenseToFolderParameters.expenseModel) ==
                true) {
              throw LocalException(
                errorModel: ErrorModel(
                  message: AppStrings.expenseIsAlreadyExistInFolder(
                      folderName: addExpenseToFolderParameters.folderName,
                      movedName:
                          addExpenseToFolderParameters.expenseModel.name),
                ),
              );
            }
            folder.expenses.add(addExpenseToFolderParameters.expenseModel);
            data.remove(element);
            data.add(folder.toJson());
            await box.put(addExpenseToFolderParameters.planName, data);
            return folder;
          }
        }
      }
      throw LocalException(
        errorModel:
            const ErrorModel(message: AppStrings.gettingFoldersErrorMessage),
      );
    } catch (e) {
      debugLog(message: e.toString());
      if (e.runtimeType == LocalException) rethrow;
      throw LocalException(
        errorModel: ErrorModel(
            message: AppStrings.addToFolderError(
                folderName: addExpenseToFolderParameters.folderName,
                movedName: addExpenseToFolderParameters.expenseModel.name)),
      );
    }
  }

  @override
  Future<void> deleteExpense(
      {required DeleteExpenseUsecaseParameters
          deleteExpenseUsecaseParameters}) async {
    try {
      final box = Hive.box(AppConstants.expensesBox);
      final folderBox = Hive.box(AppConstants.foldersBox);
      List folderData = getHiveMapValue<List>(
              key: deleteExpenseUsecaseParameters.planName, box: folderBox) ??
          [];
      List data = getHiveMapValue<List>(
              key: deleteExpenseUsecaseParameters.planName, box: box) ??
          [];

      for (var element in data) {
        ExpenseModel expenseModel = ExpenseModel.fromJson(element);
        if (expenseModel.name == deleteExpenseUsecaseParameters.expenseName) {
          data.removeWhere((element) =>
              ExpenseModel.fromJson(element).name == expenseModel.name);
          debugLog(message: data.toString());
          await box.delete(deleteExpenseUsecaseParameters.planName);
          await box.put(deleteExpenseUsecaseParameters.planName, data);
          break;
        }
      }

      List<ExpensesFolderModel> newFolders = [];
      for (var element in folderData) {
        ExpensesFolderModel expensesFolderModel =
            ExpensesFolderModel.fromJson(element);

        expensesFolderModel.expenses.removeWhere((e) {
          return e.name == deleteExpenseUsecaseParameters.expenseName;
        });
        newFolders.add(expensesFolderModel);
      }
      folderData.clear();
      for (var element in newFolders) {
        folderData.add(element.toJson());
      }
      await folderBox.delete(deleteExpenseUsecaseParameters.planName);
      await folderBox.put(deleteExpenseUsecaseParameters.planName, folderData);
    } catch (e) {
      debugLog(message: e.toString());
      throw LocalException(
          errorModel: const ErrorModel(message: AppStrings.deleteExpenseError));
    }
  }

  @override
  Future<void> removeExpenseFromFolder(
      {required RemoveExpenseFromFolderUsecaseParameters
          removeExpenseFromFolderUsecaseParameters}) async {
    try {
      final folderBox = Hive.box(AppConstants.foldersBox);
      List folderData = getHiveMapValue<List>(
              key: removeExpenseFromFolderUsecaseParameters.planName,
              box: folderBox) ??
          [];

      List<ExpensesFolderModel> newFolders = [];
      for (var element in folderData) {
        ExpensesFolderModel expensesFolderModel =
            ExpensesFolderModel.fromJson(element);
        if (expensesFolderModel.name ==
            removeExpenseFromFolderUsecaseParameters.folderName) {
          expensesFolderModel.expenses.removeWhere((e) {
            return e.name ==
                removeExpenseFromFolderUsecaseParameters.expenseName;
          });
          folderData.remove(element);
          folderData.add(expensesFolderModel.toJson());
          break;
        }
      }

      await folderBox.delete(removeExpenseFromFolderUsecaseParameters.planName);
      await folderBox.put(
          removeExpenseFromFolderUsecaseParameters.planName, folderData);
    } catch (e) {
      debugLog(message: e.toString());
      throw LocalException(
          errorModel: const ErrorModel(message: AppStrings.deleteExpenseError));
    }
  }

  @override
  Future<ExpenseModel> editExpense(
      {required EditExpenseUsecaseParameters
          editExpenseUsecaseParameters}) async {
    try {
      final box = Hive.box(AppConstants.expensesBox);
      List data = [];
      final folderBox = Hive.box(AppConstants.foldersBox);
      List folderData = getHiveMapValue<List>(
              key: editExpenseUsecaseParameters.planName, box: folderBox) ??
          [];

      if (box.containsKey(editExpenseUsecaseParameters.planName)) {
        data = getHiveMapValue(
            key: editExpenseUsecaseParameters.planName, box: box);
      }

      ExpenseModel expenseModel = ExpenseModel(
          name: editExpenseUsecaseParameters.newName,
          paid: editExpenseUsecaseParameters.newValue);
      data.removeWhere((element) =>
          ExpenseModel.fromJson(element).name ==
          editExpenseUsecaseParameters.oldName);
      data.add(expenseModel.toJson());
      box.delete(editExpenseUsecaseParameters.planName);
      await box.put(editExpenseUsecaseParameters.planName, data);

      List<ExpensesFolderModel> newFolders = [];
      for (var element in folderData) {
        ExpensesFolderModel expensesFolderModel =
            ExpensesFolderModel.fromJson(element);

        int oldIndex = expensesFolderModel.expenses.indexWhere((e) {
          return e.name == editExpenseUsecaseParameters.oldName;
        });

        if (oldIndex >= 0) {
          expensesFolderModel.expenses.removeWhere((e) {
            return e.name == editExpenseUsecaseParameters.oldName;
          });
          expensesFolderModel.expenses.insert(oldIndex, expenseModel);
          newFolders.add(expensesFolderModel);
        }
        folderData.clear();
        for (var element in newFolders) {
          folderData.add(element.toJson());
        }
        await folderBox.delete(editExpenseUsecaseParameters.planName);
        await folderBox.put(editExpenseUsecaseParameters.planName, folderData);
      }

      return expenseModel;
    } catch (e) {
      debugLog(message: e.toString());

      throw LocalException(
          errorModel: ErrorModel(
              message: e.runtimeType == LocalException
                  ? (e as LocalException).errorModel.message
                  : AppStrings.addExpenseErrorMessage));
    }
  }

  @override
  Future<void> deleteFolder(
      {required DeleteFolderUsecaseParameters
          deleteFolderUsecaseParameters}) async {
    try {
      final folderBox = Hive.box(AppConstants.foldersBox);
      List folderData = getHiveMapValue<List>(
              key: deleteFolderUsecaseParameters.planName, box: folderBox) ??
          [];

      List newFolders =
          folderData.map((e) => ExpensesFolderModel.fromJson(e)).toList();
      newFolders.removeWhere((element) =>
          element.name == deleteFolderUsecaseParameters.folderName);

      await folderBox.delete(deleteFolderUsecaseParameters.planName);
      await folderBox.put(deleteFolderUsecaseParameters.planName, newFolders);
    } catch (e) {
      debugLog(message: e.toString());
      throw LocalException(
          errorModel: const ErrorModel(message: AppStrings.deleteFolderError));
    }
  }

  @override
  Future<ExpensesFolderModel> editFolder(
      {required EditFolderUsecaseParameters
          editFolderUsecaseParameters}) async {
    try {
      List data = [];
      final folderBox = Hive.box(AppConstants.foldersBox);
      // List folderData = getHiveMapValue<List>(
      //         key: editFolderUsecaseParameters.planName, box: folderBox) ??
      //     [];

      if (folderBox.containsKey(editFolderUsecaseParameters.planName)) {
        data = getHiveMapValue(
                key: editFolderUsecaseParameters.planName, box: folderBox) ??
            [];
      }
      ExpensesFolderModel newFolder = ExpensesFolderModel(
          name: editFolderUsecaseParameters.newName,
          expenses: editFolderUsecaseParameters.expenses);
      int index = data.indexWhere((element) =>
          ExpensesFolderModel.fromJson(element).name ==
          editFolderUsecaseParameters.oldName);
      data.removeAt(index);
      data.insert(index, newFolder.toJson());

      await folderBox.delete(editFolderUsecaseParameters.planName);
      await folderBox.put(editFolderUsecaseParameters.planName, data);
      return newFolder;
    } catch (e) {
      debugLog(message: e.toString());

      throw LocalException(
          errorModel: ErrorModel(
              message: e.runtimeType == LocalException
                  ? (e as LocalException).errorModel.message
                  : AppStrings.addExpenseErrorMessage));
    }
  }
}
