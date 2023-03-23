// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';

class GetExpensesFolderUsecase
    extends BaseUsecase<Either<Failure, List<ExpensesFolderEntity>>, String> {
  final BaseHomeRepository _baseHomeRepository;

  GetExpensesFolderUsecase(this._baseHomeRepository);

  @override
  Either<Failure, List<ExpensesFolderEntity>> call(String p) {
    return _baseHomeRepository.getExpensesFolders(planName: p);
  }
}
