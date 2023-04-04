// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';

class AddExpensesFolderUsecase extends BaseUsecase<
    Future<Either<Failure, ExpensesFolderEntity>>,
    AddExpesnesFolderUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;

  AddExpensesFolderUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, ExpensesFolderEntity>> call(
      AddExpesnesFolderUsecaseParameters p) async {
    return await _baseHomeRepository.addExpensesFolder(
        name: p.name, planName: p.planName, expenses: p.expenses);
  }
}

class AddExpesnesFolderUsecaseParameters extends Equatable {
  final String name;
  final String planName;
  final List<ExpenseModel> expenses;
  const AddExpesnesFolderUsecaseParameters({
    required this.name,
    required this.planName,
    required this.expenses,
  });

  @override
  List<Object> get props => [name, planName, expenses];
}
