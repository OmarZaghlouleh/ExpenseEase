import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:flutter/material.dart';

class AppSizes {
  static const double spaceSize0 = 0;
  static const double spaceSize1 = 1;
  static const double spaceSize5 = 5;
  static const double spaceSize10 = 10;
  static const double spaceSize12 = 12;
  static const double spaceSize15 = 15;
  static const double spaceSize20 = 20;
  static const double spaceSize25 = 25;
  static const double spaceSize30 = 30;
  static const double spaceSize35 = 35;
  static const double spaceSize40 = 40;
  static const double spaceSize60 = 60;
  static const double spaceSize65 = 65;
  static const double spaceSize80 = 80;
  static const double spaceSize120 = 120;
  static const double spaceSize150 = 150;

  static const double percentIndicatorRadius = 80;

  static double getAppbarHeight(BuildContext context) =>
      getMediaQueryInstance(context: context).size.height *
      MediaQuerySizes.mq45;

  static double getAppBarBackgroundHeight(BuildContext context) =>
      getMediaQueryInstance(context: context).size.height *
      MediaQuerySizes.mq15;
}
