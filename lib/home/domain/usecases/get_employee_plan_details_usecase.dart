import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:dartz/dartz.dart';

class GetEmployeePlanDetailsUsecase
    extends BaseUsecase<Either<Failure, EmployeePlanModel>, String> {
  final BaseHomeRepository _baseHomeRepository;

  GetEmployeePlanDetailsUsecase(this._baseHomeRepository);
  @override
  Either<Failure, EmployeePlanModel> call(String p) {
    return _baseHomeRepository.getEmployeePlanEntity(planName: p);
  }
}
