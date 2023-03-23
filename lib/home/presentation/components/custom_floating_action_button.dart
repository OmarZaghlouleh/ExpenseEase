import 'package:animate_do/animate_do.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFloatingActionbutton extends StatelessWidget {
  const CustomFloatingActionbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(
      builder: (context, value, child) => Stack(
        children: [
          //Main
          Positioned(
            top: getMediaQueryInstance(context: context).size.height * 0.9,
            left: getMediaQueryInstance(context: context).size.width * 0.82,
            child: Roulette(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value.getFloatingActionButtonState
                        ? AppLightColors.primaryLightColor
                        : AppLightColors.transparent),
              ),
            ),
          ),
          //Top
          if (value.getFloatingActionButtonState)
            Positioned(
              top: getMediaQueryInstance(context: context).size.height * 0.81,
              left: getMediaQueryInstance(context: context).size.width * 0.82,
              child: SlideInUp(
                duration:
                    AnimationDuration.floatingActionButtonAnimationDuration,
                child: FloatingActionButton(
                  backgroundColor: AppLightColors.blueColor,
                  onPressed: () {},
                ),
              ),
            ),
          if (value.getFloatingActionButtonState)
            //Left
            Positioned(
              top: getMediaQueryInstance(context: context).size.height * 0.9,
              left: getMediaQueryInstance(context: context).size.width * 0.65,
              child: SlideInRight(
                duration:
                    AnimationDuration.floatingActionButtonAnimationDuration,
                child: FloatingActionButton(
                  backgroundColor: AppLightColors.blueColor,
                  onPressed: () {},
                ),
              ),
            ),
          // if (value.getFloatingActionButtonState)
          //   //top left
          //   Positioned(
          //     top: getMediaQueryInstance(context: context).size.height * 0.81,
          //     left: getMediaQueryInstance(context: context).size.width * 0.65,
          //     child: FlipInX(
          //       duration:
          //           AnimationDuration.floatingActionButtonAnimationDuration,
          //       child: FloatingActionButton(
          //         backgroundColor: AppLightColors.blueColor,
          //         onPressed: () {},
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
