import 'dart:convert';

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
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
      expenses: [],
      incomes: [],
      salary: 0,
      type: PlanType.none);

  factory EmployeePlanModel.fromJson(Map<String, dynamic> json) =>
      EmployeePlanModel(
        name: json['name'] ?? "",
        salary: double.tryParse(json['salary'].toString()) ?? 0,
        currencyType: json['currency'] ??
                AppStrings.syrianPound == AppStrings.dollarSympol
            ? CurrencyType.dollar
            : CurrencyType.syrianPound,
        type: json['type'] ?? PlanType.employee.name,
        currentBalance: json['currentBalance'] ?? 0,
        expenses: json['expenses'] ?? [],
        incomes: json['incomes'] ?? [],
      );

  String toJson() => jsonEncode({
        "type": PlanType.employee.name,
        "name": name.toString(),
        "salary": salary.toDouble().toString(),
        "currency": currencyType == CurrencyType.dollar
            ? AppStrings.dollarSympol
            : AppStrings.syrianPound,
        "currentBalance": currentBalance.toString(),
        "expenses": expenses.toString(),
        "incomes": incomes.toString(),
      });
}
