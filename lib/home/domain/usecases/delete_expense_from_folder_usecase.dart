// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';

class RemoveExpenseFromFolderUsecase extends BaseUsecase<
    Future<Either<Failure, void>>, RemoveExpenseFromFolderUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;

  RemoveExpenseFromFolderUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, void>> call(
      RemoveExpenseFromFolderUsecaseParameters p) async {
    return await _baseHomeRepository.removeExpenseFromFolder(
      planName: p.planName,
      expenseName: p.expenseName,
      folderName: p.folderName,
    );
  }
}

class RemoveExpenseFromFolderUsecaseParameters extends Equatable {
  final String planName;
  final String expenseName;
  final String folderName;
  const RemoveExpenseFromFolderUsecaseParameters({
    required this.planName,
    required this.expenseName,
    required this.folderName,
  });

  @override
  List<Object> get props => [planName, expenseName, folderName];
}
