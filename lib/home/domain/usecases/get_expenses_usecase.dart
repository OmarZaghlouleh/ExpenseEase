import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';

class GetExpensesUsecase
    extends BaseUsecase<Either<Failure, List<ExpenseEntity>>, String> {
  final BaseHomeRepository _homeRepository;

  GetExpensesUsecase(this._homeRepository);
  @override
  Either<Failure, List<ExpenseEntity>> call(String p) {
    return _homeRepository.getExpenses(planName: p);
  }
}
