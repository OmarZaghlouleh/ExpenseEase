import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';

void showDeleteDialog(
    {required BuildContext context,
    required Function function,
    List<Widget> extraActions = const <Widget>[]}) {
  List<Widget> actions = extraActions.isEmpty
      ? [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showLoadingDialog(context: context);
              function();
              Navigator.pop(context);
            },
            child: Text(
              AppStrings.yes,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppLightColors.errorColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppStrings.cancel,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppLightColors.confirmColor),
            ),
          ),
        ]
      : extraActions;
  if (extraActions.isNotEmpty) {
    actions.addAll([
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          showLoadingDialog(context: context);
          function();
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.yes,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppLightColors.errorColor),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.cancel,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppLightColors.confirmColor),
        ),
      ),
    ]);
  }
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppLightColors.dialogWithActionsBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.spaceSize15),
      ),
      elevation: AppSizes.spaceSize0,
      actions: actions,
      content: Text(
        AppStrings.areYouSure,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );
}
