import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/home/data/data_source/local_data_source.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/home/domain/usecases/add_expense_to_folder.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/delete_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_expense_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/edit_folder_usecase.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/delete_expense_from_folder_usecase.dart';

class HomeRepository implements BaseHomeRepository {
  BaseHomeLocalDataSource baseHomeLocalDataSource;

  HomeRepository(this.baseHomeLocalDataSource);
  @override
  Either<Failure, BusinessPlanModel> getBusinessPlanEntity(
      {required String planName}) {
    try {
      BusinessPlanModel businessPlanModel =
          baseHomeLocalDataSource.getBusinessPlanDetails(planName: planName);
      return Right(businessPlanModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Either<Failure, EmployeePlanModel> getEmployeePlanEntity(
      {required String planName}) {
    try {
      EmployeePlanModel businessPlanModel =
          baseHomeLocalDataSource.getEmployeePlanDetails(planName: planName);
      return Right(businessPlanModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Either<Failure, List<ExpenseModel>> getExpenses({required String planName}) {
    try {
      List<ExpenseModel> expesnes =
          baseHomeLocalDataSource.getExpesnes(planName: planName);
      return Right(expesnes);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> addExpense(
      {required String name,
      required double value,
      required String planName}) async {
    try {
      ExpenseModel expenseModel = await baseHomeLocalDataSource.addToExpense(
          addToExpenseParameters: AddToExpenseParameters(
              name: name, value: value, planNmae: planName));
      return Right(expenseModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ExpensesFolderEntity>> addExpensesFolder(
      {required String name,
      required String planName,
      required List<ExpenseModel> expenses}) async {
    try {
      ExpensesFolderModel folderModel =
          await baseHomeLocalDataSource.addExpensesFolder(
              addFolderUsecaseParameters: AddExpesnesFolderUsecaseParameters(
                  name: name, planName: planName, expenses: expenses));
      return Right(folderModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Either<Failure, List<ExpensesFolderEntity>> getExpensesFolders(
      {required String planName}) {
    try {
      List<ExpensesFolderModel> folders =
          baseHomeLocalDataSource.getExpensesFolders(planName: planName);
      return Right(folders);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ExpensesFolderModel>> addExpenseToFolder(
      {required String planName,
      required ExpenseModel expenseModel,
      required String folderName}) async {
    try {
      ExpensesFolderModel folderModel =
          await baseHomeLocalDataSource.addExpenseToFolder(
              addExpenseToFolderParameters: AddExpenseToFolderParameters(
                  planName: planName,
                  expenseModel: expenseModel,
                  folderName: folderName));
      return Right(folderModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(
      {required String planName,
      required String expenseName,
      required bool alsoFromFiles}) async {
    try {
      await baseHomeLocalDataSource.deleteExpense(
          deleteExpenseUsecaseParameters: DeleteExpenseUsecaseParameters(
              planName: planName,
              expenseName: expenseName,
              alsoFromFiles: alsoFromFiles));
      return const Right(null);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeExpenseFromFolder(
      {required String planName,
      required String expenseName,
      required String folderName}) async {
    try {
      await baseHomeLocalDataSource.removeExpenseFromFolder(
          removeExpenseFromFolderUsecaseParameters:
              RemoveExpenseFromFolderUsecaseParameters(
                  planName: planName,
                  expenseName: expenseName,
                  folderName: folderName));
      return const Right(null);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> editExpense(
      {required String newName,
      required double newValue,
      required String oldName,
      required String planName}) async {
    try {
      ExpenseModel expenseModel = await baseHomeLocalDataSource.editExpense(
          editExpenseUsecaseParameters: EditExpenseUsecaseParameters(
              newName: newName,
              newValue: newValue,
              oldName: oldName,
              planName: planName));
      return Right(expenseModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFolder(
      {required String planName, required String folderName}) async {
    try {
      await baseHomeLocalDataSource.deleteFolder(
          deleteFolderUsecaseParameters: DeleteFolderUsecaseParameters(
              planName: planName, folderName: folderName));
      return const Right(null);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, ExpensesFolderEntity>> editFolder(
      {required String planName,
      required String oldName,
      required List<ExpenseModel> expenses,
      required String newName}) async {
    try {
      final result = await baseHomeLocalDataSource.editFolder(
          editFolderUsecaseParameters: EditFolderUsecaseParameters(
              expenses: expenses,
              planName: planName,
              newName: newName,
              oldName: oldName));
      return Right(result);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }
}
