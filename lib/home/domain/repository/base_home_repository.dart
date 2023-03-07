import 'package:budgeting_app/core/error/failure.dart';

import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';

import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Either<Failure, EmployeePlanModel> getEmployeePlanEntity(
      {required String planName});
  Either<Failure, BusinessPlanModel> getBusinessPlanEntity(
      {required String planName});
}
