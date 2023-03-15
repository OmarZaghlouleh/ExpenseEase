import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/syrian_pound_icon.dart';
import 'package:budgeting_app/core/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAddExpenseModalSheet(
    {required BuildContext context,
    required TextEditingController namecontroller,
    required TextEditingController valueController,
    required CurrencyType currencyType}) {
  showModalBottomSheet(
    backgroundColor: AppLightColors.transparent,
    context: context,
    builder: (BuildContext ctx) => Container(
      height: AppSizes.spaceSize250,
      color: AppLightColors.bottomSheetBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
              controller: namecontroller,
              icon: const Icon(Icons.text_fields_rounded),
              label: AppStrings.name,
              textInputType: TextInputType.name,
              validation: (value) {}),
          CustomTextField(
              controller: valueController,
              icon: currencyType == CurrencyType.dollar
                  ? const Icon(Icons.attach_money_rounded)
                  : const SYPIcon(),
              label: AppStrings.value,
              textInputType: TextInputType.name,
              validation: (value) {}),
          ElevatedButton(onPressed: () {}, child: const Text(AppStrings.add))
        ],
      ),
    ),
  );
}
