import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showErrorDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      backgroundColor: Colors.transparent,
      elevation: AppSizes.spaceSize0,
      content: Container(
        // width: getMediaQueryInstance(context: context).size.width *
        //     MediaQuerySizes.mq5,
        // height: getMediaQueryInstance(context: context).size.height *
        //     MediaQuerySizes.mq25,
        decoration: BoxDecoration(
          color: AppLightColors.dialogBackgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.spaceSize15),
          border: Border.all(
            color: AppLightColors.errorColor,
            width: BorderSizes.b05,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LottieBuilder.asset(
                  LottieAssets.error,
                ),
              ),
              //AppSizes.spaceSize5.wh(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
