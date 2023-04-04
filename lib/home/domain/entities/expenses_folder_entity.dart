// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:equatable/equatable.dart';

class ExpensesFolderEntity extends Equatable {
  final String name;
  final List<ExpenseModel> expenses;

  const ExpensesFolderEntity({
    required this.name,
    required this.expenses,
  });

  @override
  List<Object> get props => [name, expenses];
}
