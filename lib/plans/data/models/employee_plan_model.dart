import 'dart:convert';

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';
import 'package:budgeting_app/plans/domain/entities/employee_plan_entity.dart';

class EmployeePlanModel extends EmployeePlanEntity {
  const EmployeePlanModel({
    required super.name,
    required super.salary,
    required super.currencyType,
    required super.type,
    required super.currentBalance,
    required super.expenses,
    required super.incomes,
  });

  factory EmployeePlanModel.empty() => const EmployeePlanModel(
      name: AppStrings.emptyString,
      currencyType: CurrencyType.none,
      currentBalance: 0,
      expenses: <ExpenseEntity>[],
      incomes: <IncomeEntity>[],
      salary: 0,
      type: PlanType.none);

  factory EmployeePlanModel.fromJson(Map<String, dynamic> json) =>
      EmployeePlanModel(
        name: json['name'] ?? "",
        salary: double.tryParse(json['salary'].toString()) ?? 0,
        currencyType: json['currency'].toString() == AppStrings.syrianPound
            ? CurrencyType.syrianPound
            : CurrencyType.dollar,
        type: json['type'].toString() == PlanType.employee.name
            ? PlanType.employee
            : PlanType.none,
        currentBalance: double.tryParse(json['currentBalance']) ?? 0,
        expenses: List<ExpenseEntity>.from(json['expenses']),
        incomes: List<IncomeEntity>.from(json['expenses']),
      );

  String toJsonFirst() => jsonEncode({
        "type": PlanType.employee.name,
        "name": name.toString(),
        "salary": salary.toDouble().toString(),
        "currency": currencyType == CurrencyType.dollar
            ? AppStrings.dollarSympol
            : AppStrings.syrianPound,
        "currentBalance": salary.toDouble().toString(),
        "expenses": expenses,
        "incomes": incomes,
      });
}
