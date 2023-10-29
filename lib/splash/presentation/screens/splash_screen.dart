import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/constants.dart';
import 'package:budgeting_app/core/utils/routes/routes_manager.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppLightColors.primaryLightColor,
        ),
        child: Center(
          child: AnimatedTextKit(
            repeatForever: false,
            totalRepeatCount: 1,
            onFinished: () {
              var settings = Hive.box(AppConstants.appDataBox);

              if (settings.get(AppConstants.isPlanCreated) == true) {
                Navigator.pushReplacementNamed(context, Routes.homeScreen);
              } else if (settings.get(AppConstants.isIntroskipped) == true) {
                Navigator.pushReplacementNamed(
                    context, Routes.createPlanScreen);
              } else {
                Navigator.pushReplacementNamed(context, Routes.introScreen);
              }
            },
            animatedTexts: [
              ColorizeAnimatedText(
                AppStrings.appName,
                textStyle: Theme.of(context).textTheme.headlineLarge!,
                colors: AppLightColors.splashColors,
              )
            ],
          ),
        ),
      ),
    );
  }
}
