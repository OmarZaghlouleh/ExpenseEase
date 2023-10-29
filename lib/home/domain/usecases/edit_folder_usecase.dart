// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';

class EditFolderUsecase extends BaseUsecase<
    Future<Either<Failure, ExpensesFolderEntity>>,
    EditFolderUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;
  EditFolderUsecase(this._baseHomeRepository);

  @override
  Future<Either<Failure, ExpensesFolderEntity>> call(
      EditFolderUsecaseParameters p) async {
    return await _baseHomeRepository.editFolder(
        expenses: p.expenses,
        oldName: p.oldName,
        newName: p.newName,
        planName: p.planName);
  }
}

class EditFolderUsecaseParameters extends Equatable {
  final String planName;
  final String oldName;
  final String newName;
  final List<ExpenseModel> expenses;
  const EditFolderUsecaseParameters({
    required this.expenses,
    required this.planName,
    required this.oldName,
    required this.newName,
  });

  @override
  List<Object> get props => [expenses, oldName, newName, planName];
}
