import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/font_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class EmployeePlanComponent extends StatefulWidget {
  const EmployeePlanComponent({super.key});

  @override
  State<EmployeePlanComponent> createState() => _EmployeePlanComponentState();
}

class _EmployeePlanComponentState extends State<EmployeePlanComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const Drawer(),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                stretch: true,
                pinned: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(AppPaddings.p18),
                    child: Text(
                      AppStrings.getCurrentDate(),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
                backgroundColor: AppLightColors.primaryLightColor,
                title: Row(
                  children: [
                    const Image(
                      image: AssetImage(IconAssets.employee),
                      color: AppLightColors.coloredAppbarTitleColor,
                      width: AppSizes.spaceSize25,
                      height: AppSizes.spaceSize25,
                    ),
                    AppSizes.spaceSize5.wh(),
                    Consumer<HomeProvider>(
                      builder: (context, value, child) => Text(
                        value.getEmployeePlanModel.name,
                        style: Theme.of(context)
                            .appBarTheme
                            .titleTextStyle!
                            .copyWith(
                                color: AppLightColors.coloredAppbarTitleColor),
                      ),
                    ),
                  ],
                ),
                expandedHeight: AppSizes.getAppbarHeight(context),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: Row(
                      children: [
                        AppSizes.spaceSize20.wh(),
                        Container(
                          padding: const EdgeInsets.all(AppPaddings.p8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white70),
                          child: Consumer<HomeProvider>(
                            builder: (context, value, child) =>
                                CircularPercentIndicator(
                              radius: AppSizes.percentIndicatorRadius,
                              progressColor: AppLightColors.primaryLightColor,
                              backgroundColor: AppLightColors.accentColor,
                              animation: true,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "${value.getEmployeePlanModel.salary.toString()}${getCurrencySympol(value.getEmployeePlanModel.currencyType)}"),
                                  AppSizes.spaceSize5.wh(),
                                  Text(
                                    "${getPercentInHundred(total: value.getEmployeePlanModel.salary, current: value.getEmployeePlanModel.currentBalance)}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            fontSize:
                                                FontSizes.percentFontSize),
                                  ),
                                ],
                              ),
                              percent: getPercent(
                                  total: value.getEmployeePlanModel.salary,
                                  current: value
                                      .getEmployeePlanModel.currentBalance),
                              circularStrokeCap: CircularStrokeCap.round,
                              lineWidth: BorderSizes.b12,
                            ),
                          ),
                        ),
                        AppSizes.spaceSize20.wh(),
                        const VerticalDivider(
                          color: AppLightColors.verticalDividerColor,
                          endIndent: AppSizes.spaceSize80,
                          indent: AppSizes.spaceSize80,
                        )
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Text("sss"),
                    Text("sadsd"),
                  ],
                ),
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.only(top: AppPaddings.p120),
            child: TabBarView(controller: _tabController, children: [
              ListView(
                children: List.generate(
                  50,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "sdasd",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ).toList(),
              ),
              Column(
                children: [
                  Text("sdasd"),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
