import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/dialogs/loading_dialog.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showFoldersListDialog(
    {required BuildContext context,
    required ExpenseEntity expense,
    required Function function}) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) => Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r15)),
            elevation: AppElevation.e0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<EmployeeProvider>(
                    builder: (context, value, child) => ListView(
                      shrinkWrap: true,
                      children: value.getFolders
                          .map((e) => Material(
                                child: CheckboxListTile(
                                    activeColor:
                                        AppLightColors.checkBoxActiveColor,
                                    title: ItemRow(
                                        value: e.expenses.length.toString(),
                                        name: e.name),
                                    value: value.getFoldersToAddTo
                                        .contains(e.name),
                                    onChanged: (_) {
                                      value.addFolderToAddTo(name: e.name);
                                    }),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppPaddings.p8),
                    child: ElevatedButton(
                      onPressed: () {
                        showLoadingDialog(context: context);
                        function();
                        Navigator.pop(context);
                        Navigator.pop(ctx);
                      },
                      child: const Text(AppStrings.add),
                    ),
                  ),
                ],
              ),
            ),
          ));
}
