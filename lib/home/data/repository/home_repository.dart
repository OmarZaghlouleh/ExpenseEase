import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/home/data/data_source/local_data_source.dart';
import 'package:budgeting_app/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';

class HomeRepository implements BaseHomeRepository {
  BaseHomeLocalDataSource baseHomeLocalDataSource;

  HomeRepository(this.baseHomeLocalDataSource);
  @override
  Either<Failure, BusinessPlanModel> getBusinessPlanEntity(
      {required String planName}) {
    try {
      BusinessPlanModel businessPlanModel =
          baseHomeLocalDataSource.getBusinessPlanDetails(planName: planName);
      return Right(businessPlanModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Either<Failure, EmployeePlanModel> getEmployeePlanEntity(
      {required String planName}) {
    try {
      EmployeePlanModel businessPlanModel =
          baseHomeLocalDataSource.getEmployeePlanDetails(planName: planName);
      return Right(businessPlanModel);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }
}
