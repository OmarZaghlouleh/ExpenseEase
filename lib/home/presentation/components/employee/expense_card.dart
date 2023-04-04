import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/dialogs/delete_dialog.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/presentation/components/add_expense_modal_sheet.dart';
import 'package:budgeting_app/home/presentation/components/custom_pop_up_item.dart';
import 'package:budgeting_app/home/presentation/components/folders_list_dialog.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    this.inFolder = false,
    this.folderName = "",
    required this.expense,
    required this.value,
    required this.planType,
  });

  final ExpenseEntity expense;
  final EmployeeProvider value;
  final String folderName;
  final bool inFolder;
  final PlanType planType;
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
              itemBuilder: (context) => [
                //Edit
                const PopupMenuItem(
                  value: AppConstants.edit,
                  child: CustomPopUpMenuItem(
                      title: AppStrings.edit, iconData: Icons.edit),
                ),

                //Add to folder
                const PopupMenuItem(
                  value: AppConstants.addTofolder,
                  child: CustomPopUpMenuItem(
                      title: AppStrings.addToFolder,
                      iconData: Icons.create_new_folder_rounded),
                ),
                if (inFolder)
                  //Remove from folder
                  const PopupMenuItem(
                    value: AppConstants.removeFromFolder,
                    child: CustomPopUpMenuItem(
                      title: AppStrings.removeFromFolder,
                      iconData: Icons.delete_rounded,
                      //rowColor: AppLightColors.deleteColor,
                    ),
                  ),
                //Delete
                const PopupMenuItem(
                  value: AppConstants.delete,
                  child: CustomPopUpMenuItem(
                    title: AppStrings.delete,
                    iconData: Icons.delete_rounded,
                    rowColor: AppLightColors.deleteColor,
                  ),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case AppConstants.edit:
                    showAddExpenseModalSheet(
                        context: context,
                        currencyType: Provider.of<EmployeeProvider>(context,
                                listen: false)
                            .getEmployeePlanModel
                            .currencyType,
                        edit: true,
                        oldName: expense.name,
                        oldValue: expense.paid.toString(),
                        planType: planType);
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
                  case AppConstants.removeFromFolder:
                    await Provider.of<EmployeeProvider>(context, listen: false)
                        .removeExpenseFromFolder(
                            expenseName: expense.name,
                            folderName: folderName,
                            context: context);
                    break;
                  case AppConstants.delete:
                    showDeleteDialog(
                        context: context,
                        title: AppStrings.areYouSureToDeleteIncludeFolders,
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
