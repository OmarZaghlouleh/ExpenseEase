import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';
import 'package:dartz/dartz.dart';

class ExpensesFolderModel extends ExpensesFolderEntity {
  const ExpensesFolderModel({
    required super.name,
    required super.expenses,
  });

  factory ExpensesFolderModel.fromJson(Map<dynamic, dynamic> json) {
    List items = json['items'];

    List<ExpenseModel> expesnesItems = [];

    items.forEach((element) {
      expesnesItems.add(ExpenseModel.fromJson(element));
    });

    items.forEach((e) {});
    return ExpensesFolderModel(
      name: json['name'] ?? AppStrings.emptyString,
      expenses: expesnesItems,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'items': ExpensesFolderEntity,
      };
}
