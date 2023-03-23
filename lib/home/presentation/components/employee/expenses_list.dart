import 'package:budgeting_app/core/functions/general.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/elevations.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/home/presentation/components/item_row.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({required this.scrollController, super.key});

  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(
      builder: (context, value, child) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Expanded(
          child: ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            children: value.getExpenses.reversed.map((expense) {
              return Listener(
                onPointerMove: (PointerMoveEvent event) {
                  if (scrollController.position.minScrollExtent ==
                      scrollController.offset)
                    return;
                  else if (event.position.dy <
                      MediaQuery.of(context).size.height *
                          MediaQuerySizes.mq95) {
                    scrollController.animateTo(
                        scrollController.offset - AppSizes.spaceSize120,
                        duration: const Duration(
                            milliseconds: AnimationDuration.d300),
                        curve: Curves.linear);
                  }
                },
                child: LongPressDraggable(
                  feedback: SizedBox(
                    height: AppSizes.spaceSize65,
                    width: getMediaQueryInstance(context: context).size.width *
                        MediaQuerySizes.mq95,
                    child: Card(
                      shadowColor: AppLightColors.primaryLightColor,
                      elevation: AppElevation.e2,
                      child: ItemRow(
                          name: expense.name,
                          value:
                              "${expense.paid} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}"),
                    ),
                  ),
                  child: SizedBox(
                    //height: AppSizes.spaceSize65,
                    child: Card(
                      shadowColor: AppLightColors.primaryLightColor,
                      elevation: AppElevation.e2,
                      child: ItemRow(
                          name: expense.name,
                          value:
                              "${expense.paid} ${getCurrencySympol(value.getEmployeePlanModel.currencyType)}"),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
