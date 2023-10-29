import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/plans/domain/entities/employee_plan_entity.dart';
import 'package:dartz/dartz.dart';

class GetEmployeePlanDetailsUsecase
    extends BaseUsecase<Either<Failure, EmployeePlanEntity>, String> {
  final BaseHomeRepository _baseHomeRepository;

  GetEmployeePlanDetailsUsecase(this._baseHomeRepository);
  @override
  Either<Failure, EmployeePlanEntity> call(String p) {
    return _baseHomeRepository.getEmployeePlanEntity(planName: p);
  }
}
