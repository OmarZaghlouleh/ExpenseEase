import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';

import 'package:budgeting_app/plans/domain/entities/business_plan_entity.dart';
import 'package:budgeting_app/plans/domain/entities/employee_plan_entity.dart';

import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Either<Failure, EmployeePlanEntity> getEmployeePlanEntity(
      {required String planName});
  Either<Failure, BusinessPlanEntity> getBusinessPlanEntity(
      {required String planName});
  Either<Failure, List<ExpenseEntity>> getExpenses({required String planName});
  Future<Either<Failure, ExpenseEntity>> addExpense(
      {required String name, required double value, required String planName});
  Future<Either<Failure, ExpensesFolderEntity>> addExpensesFolder(
      {required String name,
      required String planName,
      required List<ExpenseModel> expenses});
  Either<Failure, List<ExpensesFolderEntity>> getExpensesFolders(
      {required String planName});

  Future<Either<Failure, ExpensesFolderModel>> addExpenseToFolder(
      {required String planName,
      required ExpenseModel expenseModel,
      required String folderName});

  Future<Either<Failure, void>> deleteExpense({
    required String planName,
    required String expenseName,
    required bool alsoFromFiles,
  });
  Future<Either<Failure, void>> removeExpenseFromFolder({
    required String planName,
    required String expenseName,
    required String folderName,
  });

  Future<Either<Failure, ExpenseModel>> editExpense(
      {required String newName,
      required double newValue,
      required String oldName,
      required String planName});
}
