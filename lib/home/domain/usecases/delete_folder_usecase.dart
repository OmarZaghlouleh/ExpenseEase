// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';

class DeleteFolderUsecase extends BaseUsecase<Future<Either<Failure, void>>,
    DeleteFolderUsecaseParameters> {
  final BaseHomeRepository _baseHomeRepository;
  DeleteFolderUsecase(this._baseHomeRepository);
  @override
  Future<Either<Failure, void>> call(DeleteFolderUsecaseParameters p) async {
    return await _baseHomeRepository.deleteFolder(
        planName: p.planName, folderName: p.folderName);
  }
}

class DeleteFolderUsecaseParameters extends Equatable {
  final String planName;
  final String folderName;
  const DeleteFolderUsecaseParameters({
    required this.planName,
    required this.folderName,
  });

  @override
  List<Object> get props => [planName, folderName];
}
