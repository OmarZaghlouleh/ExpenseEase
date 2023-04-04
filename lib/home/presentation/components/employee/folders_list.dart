import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/home/presentation/components/employee/expense_card.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FoldersList extends StatelessWidget {
  const FoldersList({required this.scrollController, super.key});

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
          children: value.getFolders.reversed.map((folder) {
            return SizedBox(
              //height: AppSizes.spaceSize65,
              child: Card(
                shadowColor: AppLightColors.primaryLightColor,
                elevation: AppElevation.e2,
                child: ExpansionTile(
                  leading: const Icon(
                    Icons.folder_rounded,
                    color: AppLightColors.blueColor,
                  ),
                  title: Text(
                    folder.name,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppLightColors.blueColor),
                  ),
                  children: folder.expenses.reversed
                      .map<Widget>(
                        (expense) =>
                            ExpenseCard(expense: expense, value: value),
                      )
                      .toList(),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
