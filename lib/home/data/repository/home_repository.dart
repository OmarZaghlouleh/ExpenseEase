import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/home/data/data_source/local_data_source.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/home/domain/usecases/add_folder_usecase.dart';
import 'package:budgeting_app/home/domain/usecases/add_to_expense_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';

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
      required List<ExpenseEntity> expenses}) async {
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
}
