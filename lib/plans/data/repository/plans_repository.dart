import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/plans/data/data_source/local_data_source.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class PlansRepository extends BasePlansRepository {
  final BaseLocalDataSource localDataSource;

  PlansRepository(this.localDataSource);

  @override
  Future<Either<Failure, bool>> createBusinessPlan(
      {required BusinessPlanModel businessPlanModel}) async {
    try {
      await localDataSource.createBusinessPlan(
          businessPlanModel: businessPlanModel);
      return const Right(true);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<Either<Failure, bool>> createEmployeePlan(
      {required EmployeePlanModel employeePlanModel}) async {
    try {
      await localDataSource.createEmployeePlan(
          employeePlanModel: employeePlanModel);
      return const Right(true);
    } on LocalException catch (e) {
      return Left(LocalFailure(message: e.errorModel.message));
    }
  }

  @override
  Future<void> setCreatedPlanStatus({required bool status}) async {
    final box = Hive.box(AppConstants.appDataBox);
    await box.put(AppConstants.isPlanCreated, status);
  }

  @override
  Future<void> setIntroStatus({required bool status}) async {
    final box = Hive.box(AppConstants.appDataBox);
    await box.put(AppConstants.isIntroskipped, status);
  }
}
