import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/font_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/circular_progress_indicator.dart';
import 'package:budgeting_app/home/presentation/components/add_expense_dialog.dart';
import 'package:budgeting_app/home/presentation/components/custom_floating_action_button.dart';
import 'package:budgeting_app/home/presentation/components/tabBar.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        // InkWell(
        //   onTap: () {
        //     showAddExpenseModalSheet(
        //         planType: PlanType.employee,
        //         context: context,
        //         namecontroller: _nameController,
        //         valueController: _valueController,
        //         currencyType:
        //             Provider.of<EmployeeProvider>(context, listen: false)
        //                 .getEmployeePlanModel
        //                 .currencyType);
        //   },
        //   child: Container(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(AppRadius.r8),
        //         color: AppLightColors.primaryLightColor),
        //     width: AppSizes.spaceSize60,
        //     height: AppSizes.spaceSize30,
        //     child: const Icon(
        //       Icons.add,
        //       color: AppLightColors.floatingIconColor,
        //     ),
        //   ),
        // ),
        drawer: const Drawer(),
        body: Stack(
          children: [
            NestedScrollView(
              physics: const BouncingScrollPhysics(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, _) => [
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
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
                        Consumer<EmployeeProvider>(
                          builder: (context, value, child) => Text(
                            value.getEmployeePlanModel.name,
                            style: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle!
                                .copyWith(
                                    color:
                                        AppLightColors.coloredAppbarTitleColor),
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
                                  shape: BoxShape.circle,
                                  color: Colors.white70),
                              child: Consumer<EmployeeProvider>(
                                builder: (context, value, child) =>
                                    CircularPercentIndicator(
                                  radius: AppSizes.percentIndicatorRadius,
                                  progressColor:
                                      AppLightColors.primaryLightColor,
                                  backgroundColor: AppLightColors.accentColor,
                                  animation: true,
                                  percent: value.getPercent.decimal,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  lineWidth: BorderSizes.b12,
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "${value.getEmployeePlanModel.salary.toString()} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}"),
                                      AppSizes.spaceSize5.wh(),
                                      Text(
                                        "${value.getPercent.percentage}%",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                fontSize:
                                                    FontSizes.percentFontSize),
                                      ),
                                    ],
                                  ),
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
                    bottom: customTabBar(
                        tabController: _tabController, context: context),
                  ),
                ),
              ],
              body: Padding(
                padding: EdgeInsets.only(
                  top: AppSizes.getTabBarViewPadding(context),
                  left: AppPaddings.p8,
                  right: AppPaddings.p8,
                ),
                child: TabBarView(controller: _tabController, children: [
                  Consumer<EmployeeProvider>(
                    builder: (context, value, child) => value
                            .getGettingExpensesState
                        ? const CustomProgressIndicator()
                        : Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: AppPaddings.p8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.create_new_folder_rounded),
                                      color: AppLightColors.blueColor,
                                    )
                                  ],
                                ),
                              ),
                              MediaQuery.removePadding(
                                removeTop: true,
                                context: context,
                                child: Expanded(
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    children: value.getExpenses.map((expense) {
                                      return Card(
                                        shadowColor:
                                            AppLightColors.primaryLightColor,
                                        elevation: AppElevation.e2,
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.minimize_rounded,
                                            color: AppLightColors.minimizeColor,
                                          ),
                                          style: ListTileStyle.list,
                                          title: Text(
                                            expense.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                          subtitle: Text(
                                            "${expense.paid} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Column(
                    children: const [],
                  )
                ]),
              ),
            ),
            if (getMediaQueryInstance(context: context).orientation ==
                Orientation.portrait)
              const CustomFloatingActionbutton()
          ],
        ),
      ),
    );
  }
}
