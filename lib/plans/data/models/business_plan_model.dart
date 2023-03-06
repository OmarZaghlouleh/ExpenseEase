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
  });

  factory BusinessPlanModel.fromJson(Map<String, dynamic> json) =>
      BusinessPlanModel(
        name: json['name'] ?? "",
        currencyType: json['currency'] ??
                AppStrings.syrianPound == AppStrings.dollarSympol
            ? CurrencyType.dollar
            : CurrencyType.syrianPound,
        planType: json['type'] ?? PlanType.business.name,
      );

  String toJson() => jsonEncode({
        "type": PlanType.business.name,
        "name": name.toString(),
        "currency": currencyType == CurrencyType.dollar
            ? AppStrings.dollarSympol
            : AppStrings.syrianPound,
      });
}
