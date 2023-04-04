import 'dart:developer';

import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';

class ExpensesFolderModel extends ExpensesFolderEntity {
  const ExpensesFolderModel({
    required super.name,
    required super.expenses,
  });

  factory ExpensesFolderModel.fromJson(Map<dynamic, dynamic> json) {
    log(json.toString());
    List items = json['items'] ?? [];

    List<ExpenseModel> expesnesItems = [];

    for (var element in items) {
      expesnesItems.add(ExpenseModel.fromJson(element));
    }

    return ExpensesFolderModel(
      name: json['name'] ?? AppStrings.emptyString,
      expenses: expesnesItems,
    );
  }

  Map<String, dynamic> toJson() {
    List expensesJson = [];

    for (var element in expenses) {
      expensesJson.add(element.toJson());
    }
    return {
      'name': name,
      'items': expensesJson,
    };
  }
}
