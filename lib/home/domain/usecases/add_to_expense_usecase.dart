// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';

class AddToExpenseUsecase extends BaseUsecase<
    Future<Either<Failure, ExpenseEntity>>, AddToExpenseParameters> {
  final BaseHomeRepository _homeRepository;
  AddToExpenseUsecase(this._homeRepository);

  @override
  Future<Either<Failure, ExpenseEntity>> call(AddToExpenseParameters p) async {
    return await _homeRepository.addExpense(
        name: p.name, value: p.value, planName: p.planNmae);
  }
}

class AddToExpenseParameters extends Equatable {
  final String name;
  final String planNmae;

  final double value;

  const AddToExpenseParameters(
      {required this.name, required this.value, required this.planNmae});

  @override
  List<Object> get props => [name, value, planNmae];
}
