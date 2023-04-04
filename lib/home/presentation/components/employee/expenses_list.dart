import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/presentation/components/custom_pop_up_item.dart';
import 'package:budgeting_app/home/presentation/components/employee/expense_card.dart';
import 'package:budgeting_app/home/presentation/components/folders_list_dialog.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.scrollController, super.key});

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(
      builder: (context, value, child) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          children: value.getExpenses.reversed.map((expense) {
            return ExpenseCard(expense: expense, value: value);
          }).toList(),
        ),
      ),
    );
  }
}
