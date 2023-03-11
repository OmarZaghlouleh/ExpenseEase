import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class BusinessPlanComponent extends StatefulWidget {
  const BusinessPlanComponent({super.key});

  @override
  State<BusinessPlanComponent> createState() => _BusinessPlanComponentState();
}

class _BusinessPlanComponentState extends State<BusinessPlanComponent>
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
        drawer: Drawer(),
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
                title: Consumer<HomeProvider>(
                  builder: (context, value, child) => Text(
                    value.getBusinessPlanModel.name,
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle!
                        .copyWith(
                            color: AppLightColors.coloredAppbarTitleColor),
                  ),
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
