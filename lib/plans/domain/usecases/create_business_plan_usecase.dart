// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/core/error/failure.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:budgeting_app/plans/domain/repository/base_plans_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/base_usecase.dart';
import 'package:budgeting_app/core/utils/enums.dart';

class CreateBusinessPlanUsecase
    extends BaseUsecase<Future<Either<Failure, void>>, BusinessPlanModel> {
  final BasePlansRepository basePlansRepository;

  CreateBusinessPlanUsecase(this.basePlansRepository);
  @override
  Future<Either<Failure, void>> call(BusinessPlanModel p) async {
    return await basePlansRepository.createBusinessPlan(businessPlanModel: p);
  }
}

class CreateBusinessPlanUsecaseParameters extends Equatable {
  final String name;
  final CurrencyType currencyType;
  const CreateBusinessPlanUsecaseParameters({
    required this.name,
    required this.currencyType,
  });

  @override
  List<Object> get props => [name, currencyType];
}
