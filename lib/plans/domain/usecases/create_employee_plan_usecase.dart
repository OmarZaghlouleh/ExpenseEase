// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/plans/data/models/employee_plan_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';

class CreateEmployeePlanUsecase
    extends BaseUsecase<Future<Either<Failure, void>>, EmployeePlanModel> {
  final BasePlansRepository basePlansRepository;

  CreateEmployeePlanUsecase(this.basePlansRepository);
  @override
  Future<Either<Failure, bool>> call(EmployeePlanModel p) async {
    log("sadsd");
    return await basePlansRepository.createEmployeePlan(employeePlanModel: p);
  }
}

class CreateEmployeePlanUsecaseParameters extends Equatable {
  final String name;
  final double salary;
  final CurrencyType currencyType;

  const CreateEmployeePlanUsecaseParameters(
      {required this.name, required this.salary, required this.currencyType});

  @override
  List<Object> get props => [name, salary, currencyType];
}
