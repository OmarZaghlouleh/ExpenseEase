import 'package:budgeting_app/core/utils/enums.dart';

import 'package:budgeting_app/home/presentation/components/employee/expense_card.dart';

import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.scrollController, super.key, required this.planType});

  final ScrollController scrollController;
  final PlanType planType;
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(
      builder: (context, value, child) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            value.reorderExpenses(oldIndex: oldIndex, newIndex: newIndex);
          },
          scrollController: scrollController,
          physics: const BouncingScrollPhysics(),
          children: value.getExpenses.map((expense) {
            return ExpenseCard(
              key: Key(expense.name),
              expense: expense,
              value: value,
              planType: planType,
            );
          }).toList(),
        ),
      ),
    );
  }
}
