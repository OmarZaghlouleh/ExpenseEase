import 'dart:convert';

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/plans/domain/entities/business_plan_entity.dart';
import 'package:budgeting_app/plans/domain/entities/employee_plan_entity.dart';

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
      expenses: [],
      incomes: []);

  factory BusinessPlanModel.fromJson(Map<String, dynamic> json) =>
      BusinessPlanModel(
        name: json['name'] ?? "",
        currencyType: json['currency'] ??
                AppStrings.syrianPound == AppStrings.dollarSympol
            ? CurrencyType.dollar
            : CurrencyType.syrianPound,
        planType: json['type'] ?? PlanType.business.name,
        currentBalance: json['currentBalance'] ?? 0,
        expenses: json['expenses'] ?? [],
        incomes: json['incomes'] ?? [],
      );

  String toJson() => jsonEncode({
        "type": PlanType.business.name,
        "name": name.toString(),
        "currency": currencyType == CurrencyType.dollar
            ? AppStrings.dollarSympol
            : AppStrings.syrianPound,
        "currentBalance": currentBalance.toString(),
        "expenses": expenses.toString(),
        "incomes": incomes.toString(),
      });
}
