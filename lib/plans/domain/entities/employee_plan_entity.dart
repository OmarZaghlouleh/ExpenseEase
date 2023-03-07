// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';

class EmployeePlanEntity extends Equatable {
  final PlanType type;
  final String name;
  final double salary;
  final CurrencyType currencyType;
  final double currentBalance;
  final List<ExpenseEntity> expenses;
  final List<IncomeEntity> incomes;

  const EmployeePlanEntity({
    required this.type,
    required this.name,
    required this.salary,
    required this.currencyType,
    required this.currentBalance,
    required this.expenses,
    required this.incomes,
  });

  @override
  List<Object> get props {
    return [
      type,
      name,
      salary,
      currencyType,
      currentBalance,
      expenses,
      incomes,
    ];
  }
}
