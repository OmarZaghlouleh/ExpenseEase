// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';

class EditExpenseUsecase extends BaseUsecase<
    Future<Either<Failure, ExpenseModel>>, EditExpenseUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;

  EditExpenseUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, ExpenseModel>> call(
      EditExpenseUsecaseParameters p) async {
    return await _baseHomeRepository.editExpense(
        newName: p.newName,
        newValue: p.newValue,
        oldName: p.oldName,
        planName: p.planName);
  }
}

class EditExpenseUsecaseParameters extends Equatable {
  final String newName;
  final double newValue;
  final String oldName;
  final String planName;

  const EditExpenseUsecaseParameters({
    required this.newName,
    required this.newValue,
    required this.oldName,
    required this.planName,
  });

  @override
  List<Object> get props => [newName, newValue, oldName, planName];
}
