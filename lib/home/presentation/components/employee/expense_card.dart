import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/dialogs/delete_dialog.dart';
import 'package:budgeting_app/core/widgets/dialogs/loading_dialog.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/presentation/components/custom_pop_up_item.dart';
import 'package:budgeting_app/home/presentation/components/folders_list_dialog.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense, required this.value});

  final ExpenseEntity expense;
  final EmployeeProvider value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shadowColor: AppLightColors.primaryLightColor,
        elevation: AppElevation.e2,
        child: Row(
          children: [
            Expanded(
              child: ItemRow(
                  name: expense.name,
                  value:
                      "${expense.paid} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}"),
            ),
            PopupMenuButton(
              color: AppLightColors.accentColor.withOpacity(AppOpacity.op08),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.r15),
                  bottomLeft: Radius.circular(AppRadius.r15),
                  bottomRight: Radius.circular(AppRadius.r15),
                ),
              ),
              shadowColor: AppLightColors.primaryLightColor,
              elevation: AppElevation.e5,
              itemBuilder: (context) => const [
                //Edit
                PopupMenuItem(
                  value: AppConstants.edit,
                  child: CustomPopUpMenuItem(
                      title: AppStrings.edit, iconData: Icons.edit),
                ),

                //Add to folder
                PopupMenuItem(
                  value: AppConstants.addTofolder,
                  child: CustomPopUpMenuItem(
                      title: AppStrings.addToFolder,
                      iconData: Icons.create_new_folder_rounded),
                ),
                //Delete
                PopupMenuItem(
                  value: AppConstants.delete,
                  child: CustomPopUpMenuItem(
                    title: AppStrings.delete,
                    iconData: Icons.delete_rounded,
                    rowColor: AppLightColors.deleteColor,
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case AppConstants.edit:
                    break;
                  case AppConstants.addTofolder:
                    Provider.of<EmployeeProvider>(context, listen: false)
                        .clearFoldersToAddTo();
                    showFoldersListDialog(
                        context: context,
                        expense: expense,
                        function: () async {
                          await Provider.of<EmployeeProvider>(context,
                                  listen: false)
                              .addExpenseToFolder(
                                  expenseModel: ExpenseModel(
                                      name: expense.name, paid: expense.paid),
                                  context: context)
                              .then((value) {});
                        });

                    break;
                  case AppConstants.delete:
                    showDeleteDialog(
                        context: context,
                        function: () async {
                          await Provider.of<EmployeeProvider>(context,
                                  listen: false)
                              .deleteExpense(
                                  expenseName: expense.name, context: context);
                        });
                    break;
                  default:
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
