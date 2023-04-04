// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';

class DeleteExpenseUsecase extends BaseUsecase<Future<Either<Failure, void>>,
    DeleteExpenseUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;

  DeleteExpenseUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, void>> call(DeleteExpenseUsecaseParameters p) async {
    return await _baseHomeRepository.deleteExpense(
        planName: p.planName,
        expenseName: p.expenseName,
        alsoFromFiles: p.alsoFromFiles);
  }
}

class DeleteExpenseUsecaseParameters extends Equatable {
  final String planName;
  final String expenseName;
  final bool alsoFromFiles;
  const DeleteExpenseUsecaseParameters({
    required this.planName,
    required this.alsoFromFiles,
    required this.expenseName,
  });

  @override
  List<Object> get props => [planName, expenseName];
}
