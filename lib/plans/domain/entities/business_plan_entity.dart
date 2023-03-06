// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/utils/enums.dart';

class BusinessPlanEntity extends Equatable {
  final PlanType planType;
  final String name;
  final CurrencyType currencyType;
  const BusinessPlanEntity({
    required this.planType,
    required this.name,
    required this.currencyType,
  });

  @override
  List<Object> get props => [name, currencyType];
}
