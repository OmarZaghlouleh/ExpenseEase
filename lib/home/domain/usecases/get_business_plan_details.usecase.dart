import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:budgeting_app/plans/domain/entities/business_plan_entity.dart';
import 'package:dartz/dartz.dart';

class GetBusinessPlanDetailsUsecase
    extends BaseUsecase<Either<Failure, BusinessPlanEntity>, String> {
  final BaseHomeRepository _baseHomeRepository;

  GetBusinessPlanDetailsUsecase(this._baseHomeRepository);
  @override
  Either<Failure, BusinessPlanEntity> call(String p) {
    return _baseHomeRepository.getBusinessPlanEntity(planName: p);
  }
}
