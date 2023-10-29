// ignore_for_file: use_build_context_synchronously

import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/domain/entities/expenses_folder_entity.dart';
import 'package:budgeting_app/home/presentation/components/add_folder_modal_sheet.dart';
import 'package:budgeting_app/home/presentation/components/custom_pop_up_item.dart';
import 'package:budgeting_app/home/presentation/components/employee/expense_card.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FolderCard extends StatelessWidget {
  const FolderCard(
      {super.key, required this.folder, required this.employeeProvider});
  final ExpensesFolderEntity folder;
  final EmployeeProvider employeeProvider;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: PopupMenuButton(
          icon: const Icon(Icons.settings_rounded),
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
                showFolderModalSheet(
                    context: context,
                    edit: true,
                    folder: folder,
                    planType: employeeProvider.getEmployeePlanModel.type);

                break;

              case AppConstants.delete:
                await Provider.of<EmployeeProvider>(context, listen: false)
                    .deleteFolder(folderName: folder.name, context: context);
                break;
              default:
            }
          },
        ),
        children: const [],
      ),
      child: SizedBox(
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
                  (expense) => ExpenseCard(
                    expense: expense,
                    value: employeeProvider,
                    inFolder: true,
                    folderName: folder.name,
                    planType: employeeProvider.getEmployeePlanModel.type,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
