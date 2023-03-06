// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/utils/enums.dart';

class EmployeePlanEntity extends Equatable {
  final PlanType type;
  final String name;
  final double salary;
  final CurrencyType currencyType;
  const EmployeePlanEntity({
    required this.type,
    required this.name,
    required this.salary,
    required this.currencyType,
  });

  @override
  List<Object> get props => [name, salary, currencyType];
}
