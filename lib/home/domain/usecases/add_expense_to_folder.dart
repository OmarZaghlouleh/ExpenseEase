// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/data/models/folder_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';

class AddExpenseToFolderUsecase extends BaseUsecase<
    Future<Either<Failure, ExpensesFolderModel>>,
    AddExpenseToFolderParameters> {
  BaseHomeRepository baseHomeRepository;
  AddExpenseToFolderUsecase(this.baseHomeRepository);
  @override
  Future<Either<Failure, ExpensesFolderModel>> call(p) async {
    return await baseHomeRepository.addExpenseToFolder(
        planName: p.planName,
        expenseModel: p.expenseModel,
        folderName: p.folderName);
  }
}

class AddExpenseToFolderParameters extends Equatable {
  final String planName;
  final ExpenseModel expenseModel;
  final String folderName;
  const AddExpenseToFolderParameters({
    required this.planName,
    required this.expenseModel,
    required this.folderName,
  });

  @override
  List<Object> get props => [planName, expenseModel, folderName];
}
