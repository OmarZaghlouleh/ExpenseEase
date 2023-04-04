import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/text_field_widget.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showFolderModalSheet({
  required BuildContext context,
  // required TextEditingController namecontroller,
  required PlanType planType,
}) {
  final TextEditingController nameController = TextEditingController();

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
                  if (value == null || value.isEmpty) return AppStrings.invalid;
                }),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(ctx);
                  switch (planType) {
                    case PlanType.employee:
                      await Provider.of<EmployeeProvider>(context,
                              listen: false)
                          .addFolder(
                        context: context,
                        name: nameController.text.trim(),
                      );
                      break;
                    case PlanType.business:
                      break;
                    case PlanType.none:
                      return;
                  }
                  nameController.clear();
                }
              },
              child: const Text(AppStrings.add),
            )
          ],
        ),
      ),
    ),
  );
}
