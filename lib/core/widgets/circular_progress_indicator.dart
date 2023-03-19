import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.spaceSize35,
        height: AppSizes.spaceSize35,
        child: CircularProgressIndicator(
          color: AppLightColors.primaryLightColor,
          strokeWidth: AppSizes.spaceSize1,
        ),
      ),
    );
  }
}
