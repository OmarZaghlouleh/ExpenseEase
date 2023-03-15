import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SYPIcon extends StatelessWidget {
  const SYPIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: AppSizes.spaceSize1,
      heightFactor: AppSizes.spaceSize1,
      child: Text(
        AppStrings.syrianPound,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
