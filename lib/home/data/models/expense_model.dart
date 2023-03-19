import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  const ExpenseModel({required super.name, required super.paid});

  factory ExpenseModel.fromJson(Map<dynamic, dynamic> json) => ExpenseModel(
        name: json['name'] ?? AppStrings.emptyString,
        paid: json['paid'] ?? 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'paid': paid,
    };
  }
}
