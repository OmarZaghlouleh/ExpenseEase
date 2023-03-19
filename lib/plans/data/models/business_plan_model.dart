import 'dart:convert';

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';
import 'package:budgeting_app/plans/domain/entities/business_plan_entity.dart';

class BusinessPlanModel extends BusinessPlanEntity {
  const BusinessPlanModel({
    required super.name,
    required super.currencyType,
    required super.planType,
    required super.currentBalance,
    required super.expenses,
    required super.incomes,
  });

  factory BusinessPlanModel.empty() => const BusinessPlanModel(
      name: AppStrings.emptyString,
      currencyType: CurrencyType.none,
      planType: PlanType.none,
      currentBalance: 0,
      expenses: <ExpenseEntity>[],
      incomes: <IncomeEntity>[]);

  factory BusinessPlanModel.fromJson(Map<String, dynamic> json) =>
      BusinessPlanModel(
        name: json['name'] ?? "",
        currencyType: json['currency'].toString() == AppStrings.syrianPound
            ? CurrencyType.syrianPound
            : CurrencyType.dollar,
        planType: json['type'].toString() == PlanType.business.name
            ? PlanType.business
            : PlanType.none,
        currentBalance: double.tryParse(json['currentBalance']) ?? 0,
        expenses: List<ExpenseEntity>.from(json['expenses']),
        incomes: List<IncomeEntity>.from(json['expenses']),
      );

  String toJson() => jsonEncode({
        "type": PlanType.business.name,
        "name": name.toString(),
        "currency": currencyType == CurrencyType.dollar
            ? AppStrings.dollarSympol
            : AppStrings.syrianPound,
        "currentBalance": currentBalance.toString(),
        "expenses": expenses,
        "incomes": incomes,
      });
}
