import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customTabBar(
        {required TabController tabController,
        required BuildContext context}) =>
    AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(bottom: AppPaddings.p8),
        child: Container(
          width: getMediaQueryInstance(context: context).size.width *
              MediaQuerySizes.mq90,
          height: AppSizes.spaceSize40,
          decoration: BoxDecoration(
            color: AppLightColors.tabBarBackgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
          child: TabBar(
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            controller: tabController,
            tabs: const [
              Text(AppStrings.expenses),
              Text(AppStrings.incomes),
            ],
          ),
        ),
      ),
    );
