// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/opacity.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/sizes/space_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/nothing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlanContainer extends StatelessWidget {
  const PlanContainer(
      {required this.title,
      required this.description,
      required this.iconAsset,
      required this.isSelected,
      super.key});

  final String title;
  final String description;
  final String iconAsset;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? AppLightColors.primaryLightColor.withOpacity(AppOpacity.op05)
                : AppLightColors.accentColor.withOpacity(AppOpacity.op03),
            borderRadius: BorderRadius.circular(10)),
        height: getMediaQueryInstance(context: context).size.height *
            MediaQuerySizes.mq45,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppPaddings.p50, horizontal: AppPaddings.p15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Image(
                    image: AssetImage(iconAsset),
                    width: AppSizes.spaceSize60,
                    height: AppSizes.spaceSize60,
                  ),
                ),
              ),
              //AppSizes.spaceSize25.wh(),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(decoration: TextDecoration.underline)),
                ),
              ),
              //AppSizes.spaceSize5.wh(),
              Expanded(
                flex: 2,
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.start,
                ),
              ),
              //AppSizes.spaceSize40.wh(),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: AppSizes.spaceSize40,
                    height: AppSizes.spaceSize40,
                    child: isSelected
                        ? JelloIn(
                            child: SvgPicture.asset(
                              IconAssets.checkmarkIcon,
                              color: Colors.white,
                            ),
                          )
                        : emptyWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
