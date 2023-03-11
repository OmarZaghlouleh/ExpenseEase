import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/media_query.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/plans/presentation/components/Create%20plan%20components/plan_container.dart';
import 'package:budgeting_app/plans/presentation/controller/create_plan_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SelectPlanTypeSection extends StatelessWidget {
  const SelectPlanTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizes.spaceSize25.wh(),
        Padding(
          padding: const EdgeInsets.all(AppPaddings.p15),
          child: Text(
            AppStrings.selectYourPlan,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        AppSizes.spaceSize20.wh(),
        Consumer<CreatePlanProvider>(
          builder: (context, value, child) => Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(AppPaddings.p8),
                  child: InkWell(
                    onTap: () => value.setPlanType(PlanType.employee),
                    child: PlanContainer(
                      title: AppStrings.employeePlan,
                      description: AppStrings.employeePlanDescription,
                      iconAsset: IconAssets.employee,
                      isSelected:
                          value.getPlanType == PlanType.employee ? true : false,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(AppPaddings.p8),
                  child: InkWell(
                    onTap: () => value.setPlanType(PlanType.business),
                    child: PlanContainer(
                      title: AppStrings.businessPlan,
                      description: AppStrings.businessPlanDescription,
                      iconAsset: IconAssets.business,
                      isSelected:
                          value.getPlanType == PlanType.business ? true : false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
