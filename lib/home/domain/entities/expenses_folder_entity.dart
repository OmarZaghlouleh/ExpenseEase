// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/domain/entities/income_entity.dart';

class ExpensesFolderEntity extends Equatable {
  final String name;
  final List<ExpenseEntity> expenses;

  const ExpensesFolderEntity({
    required this.name,
    required this.expenses,
  });

  @override
  List<Object> get props => [name, expenses];
}
