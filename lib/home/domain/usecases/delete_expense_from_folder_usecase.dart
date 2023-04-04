// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';

class DeleteExpenseFromFolderUsecase extends BaseUsecase<
    Future<Either<Failure, void>>, DeleteExpenseFromFolderUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;

  DeleteExpenseFromFolderUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, void>> call(
      DeleteExpenseFromFolderUsecaseParameters p) async {
    return await _baseHomeRepository.deleteExpenseFromFolder(
      planName: p.planName,
      expenseName: p.expenseName,
      folderName: p.folderName,
    );
  }
}

class DeleteExpenseFromFolderUsecaseParameters extends Equatable {
  final String planName;
  final String expenseName;
  final String folderName;
  const DeleteExpenseFromFolderUsecaseParameters({
    required this.planName,
    required this.expenseName,
    required this.folderName,
  });

  @override
  List<Object> get props => [planName, expenseName, folderName];
}
