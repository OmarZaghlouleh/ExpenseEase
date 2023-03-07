import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/domain/entities/business_plan_entity.dart';
import 'package:dartz/dartz.dart';

class GetBusinessPlanDetailsUsecase
    extends BaseUsecase<Either<Failure, BusinessPlanModel>, String> {
  final BaseHomeRepository _baseHomeRepository;

  GetBusinessPlanDetailsUsecase(this._baseHomeRepository);
  @override
  Either<Failure, BusinessPlanModel> call(String p) {
    return _baseHomeRepository.getBusinessPlanEntity(planName: p);
  }
}
