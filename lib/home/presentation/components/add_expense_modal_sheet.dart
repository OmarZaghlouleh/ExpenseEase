import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/syrian_pound_icon.dart';
import 'package:budgeting_app/core/widgets/text_field_widget.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAddExpenseModalSheet(
    {required BuildContext context,
    bool edit = false,
    String oldName = "",
    String oldValue = "",
    required CurrencyType currencyType,
    required PlanType planType}) {
  final TextEditingController nameController = TextEditingController();
  nameController.text = oldName;
  final TextEditingController valueController = TextEditingController();
  valueController.text = oldValue;
  GlobalKey<FormState> formKey = GlobalKey();
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppLightColors.transparent,
    context: context,
    builder: (BuildContext ctx) => Container(
      padding: EdgeInsets.only(
          bottom: getMediaQueryInstance(context: ctx).viewInsets.bottom),
      color: AppLightColors.bottomSheetBackgroundColor,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextField(
                // autoFocus: true,
                controller: nameController,
                icon: const Icon(Icons.text_fields_rounded),
                label: AppStrings.name,
                textInputType: TextInputType.name,
                validation: (value) {
                  if (value == null) return AppStrings.invalid;
                  return null;
                }),
            CustomTextField(
                controller: valueController,
                icon: currencyType == CurrencyType.dollar
                    ? const Icon(Icons.attach_money_rounded)
                    : const SYPIcon(),
                label: AppStrings.value,
                textInputType: TextInputType.number,
                validation: (value) {
                  if (double.tryParse(value ?? "") == null) {
                    return AppStrings.invalid;
                  }
                  return null;
                }),
            Padding(
              padding: const EdgeInsets.all(AppPaddings.p8),
              child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(ctx);
                      switch (planType) {
                        case PlanType.employee:
                          if (edit) {
                            if (nameController.text.trim() == oldName &&
                                valueController.text.trim() == oldValue) return;
                            await Provider.of<EmployeeProvider>(context,
                                    listen: false)
                                .editExpense(
                                    newName: nameController.text.trim(),
                                    oldName: oldName,
                                    newValue: double.tryParse(
                                            valueController.text.trim()) ??
                                        0,
                                    context: context);
                          } else {
                            await Provider.of<EmployeeProvider>(context,
                                    listen: false)
                                .addToExpenses(
                                    context: context,
                                    name: nameController.text.trim(),
                                    value: double.tryParse(
                                            valueController.text.trim()) ??
                                        0);
                          }
                          break;
                        case PlanType.business:
                          break;
                        case PlanType.none:
                          return;
                      }
                      nameController.clear();
                      valueController.clear();
                    }
                  },
                  child: Text(edit ? AppStrings.edit : AppStrings.add)),
            )
          ],
        ),
      ),
    ),
  );
}
