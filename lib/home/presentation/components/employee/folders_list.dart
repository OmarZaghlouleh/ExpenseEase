import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
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
        child: Expanded(
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
                          (expense) => ItemRow(
                              value:
                                  "${expense.paid} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}",
                              name: expense.name),
                        )
                        .toList(),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
