import 'dart:developer';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/functions/get_widget_location.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/font_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/circular_progress_indicator.dart';
import 'package:budgeting_app/home/data/models/expense_model.dart';
import 'package:budgeting_app/home/domain/entities/expense_entity.dart';
import 'package:budgeting_app/home/presentation/components/add_expense_modal_sheet.dart';
import 'package:budgeting_app/home/presentation/components/add_folder_modal_sheet.dart';
import 'package:budgeting_app/home/presentation/components/custom_floating_action_button.dart';
import 'package:budgeting_app/home/presentation/components/employee/expenses_list.dart';
import 'package:budgeting_app/home/presentation/components/employee/folders_list.dart';
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

  final ScrollController _foldersScrollController = ScrollController();
  final ScrollController _expensesScrollController = ScrollController();
  final PageController _pageController = PageController();

  final _listViewKey = GlobalKey();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _foldersScrollController.dispose();
    _expensesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            if (_pageController.page != 0) {
                                              _pageController.previousPage(
                                                  duration: const Duration(
                                                      milliseconds:
                                                          AnimationDuration
                                                              .d500),
                                                  curve: Curves.linear);
                                              value.changeFileVisibilty();
                                            }
                                            showAddExpenseModalSheet(
                                                context: context,
                                                currencyType: value
                                                    .getEmployeePlanModel
                                                    .currencyType,
                                                planType: PlanType.employee);
                                          },
                                          child:
                                              const Text(AppStrings.addExpense),
                                        ),
                                        const SizedBox(
                                          height: AppSizes.spaceSize20,
                                          child: VerticalDivider(
                                            color: AppLightColors
                                                .verticalDividerColorForWhiteBackground,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_pageController.page == 0) {
                                              _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds:
                                                          AnimationDuration
                                                              .d500),
                                                  curve: Curves.linear);
                                              value.changeFileVisibilty();
                                            }
                                            showFolderModalSheet(
                                                context: context,
                                                planType: PlanType.employee);
                                          },
                                          child: Text(
                                            AppStrings.addFolder,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .copyWith(
                                                    color: AppLightColors
                                                        .blueColor,
                                                    fontSize: FontSizes
                                                        .buttonFontSize),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Consumer<EmployeeProvider>(
                                      builder: (context, value, child) =>
                                          InkWell(
                                        onTap: () {
                                          value.triggerFileVisibility(
                                              pageController: _pageController);
                                        },
                                        child: Icon(
                                          value.getFileVisibility
                                              ? Icons.menu
                                              : Icons.folder_rounded,
                                          color: value.getFileVisibility
                                              ? AppLightColors.primaryLightColor
                                              : AppLightColors.blueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: PageView(
                                  controller: _pageController,
                                  children: [
                                    ExpensesList(
                                        scrollController:
                                            _expensesScrollController),
                                    FoldersList(
                                        scrollController:
                                            _foldersScrollController),
                                  ],
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
            // if (getMediaQueryInstance(context: context).orientation ==
            //     Orientation.portrait)
            //   const CustomFloatingActionbutton()
          ],
        ),
      ),
    );
  }
}
