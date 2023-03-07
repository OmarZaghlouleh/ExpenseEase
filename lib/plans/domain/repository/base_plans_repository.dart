import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:dartz/dartz.dart';

abstract class BasePlansRepository {
  Future<Either<Failure, bool>> createEmployeePlan(
      {required EmployeePlanModel employeePlanModel});
  Future<Either<Failure, bool>> createBusinessPlan(
      {required BusinessPlanModel businessPlanModel});
}
