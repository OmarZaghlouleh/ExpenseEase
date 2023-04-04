import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomPopUpMenuItem extends StatelessWidget {
  const CustomPopUpMenuItem(
      {super.key,
      required this.title,
      required this.iconData,
      this.rowColor = AppLightColors.popUpRowColor});

  final String title;
  final IconData iconData;
  final Color rowColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: rowColor,
        ),
        AppSizes.spaceSize10.wh(),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: rowColor),
        ),
      ],
    );
  }
}
