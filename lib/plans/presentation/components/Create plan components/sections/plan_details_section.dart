import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/functions/validations.dart';
import 'package:budgeting_app/core/utils/assets/assets_path.dart';
import 'package:budgeting_app/core/utils/colors/app_light_colors.dart';
import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/sizes/borders.dart';
import 'package:budgeting_app/core/utils/sizes/media_query_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/core/widgets/text_field_widget.dart';
import 'package:budgeting_app/plans/presentation/controller/create_plan_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanDetailsSection extends StatelessWidget {
  const PlanDetailsSection(
      {required this.pageController,
      required this.formKey,
      required this.nameController,
      required this.salaryController,
      super.key});

  final PageController pageController;

  final TextEditingController nameController;
  final TextEditingController salaryController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: Theme.of(context).textButtonTheme.style!.copyWith(
                    foregroundColor:
                        MaterialStateProperty.all(AppLightColors.blueColor)),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppLightColors.blueColor,
                      size: AppSizes.spaceSize12,
                    ),
                    AppSizes.spaceSize5.wh(),
                    const Text(
                      AppStrings.changePlanType,
                    ),
                  ],
                ),
                onPressed: () {
                  pageController.previousPage(
                      duration: Duration(milliseconds: AnimationDuration.d300),
                      curve: Curves.linear);
                },
              ),
            ),
            (MediaQuery.of(context).size.height * MediaQuerySizes.mq20).wh(),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPaddings.p8, right: AppPaddings.p8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                        color: AppLightColors.primaryLightColor,
                        width: BorderSizes.b05,
                      ),
                      bottom: BorderSide(
                        color: AppLightColors.primaryLightColor,
                        width: BorderSizes.b05,
                      )),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPaddings.p15),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(Provider.of<CreatePlanProvider>(
                                            context,
                                            listen: false)
                                        .getPlanType ==
                                    PlanType.employee
                                ? IconAssets.employee
                                : IconAssets.business),
                            color: AppLightColors.primaryLightColor,
                            width: AppSizes.spaceSize25,
                            height: AppSizes.spaceSize25,
                          ),
                          AppSizes.spaceSize5.wh(),
                          Text(
                            AppStrings.planDetails + AppStrings.colon,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      controller: nameController,
                      icon: const Icon(Icons.person),
                      label: AppStrings.name,
                      textInputType: TextInputType.name,
                      validation: validateName,
                    ),
                    if (Provider.of<CreatePlanProvider>(context, listen: false)
                            .getPlanType ==
                        PlanType.employee)
                      Consumer<CreatePlanProvider>(
                        builder: (context, value, child) => CustomTextField(
                          controller: salaryController,
                          icon: value.getCurrencyType == CurrencyType.dollar
                              ? const Icon(Icons.attach_money_rounded)
                              : Align(
                                  widthFactor: AppSizes.spaceSize1,
                                  heightFactor: AppSizes.spaceSize1,
                                  child: Text(
                                    AppStrings.syrianPound,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                          label: AppStrings.salary,
                          textInputType: TextInputType.number,
                          validation: validateSalary,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(AppPaddings.p15),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.currency + AppStrings.colon,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            width: AppSizes.spaceSize80,
                            height: AppSizes.spaceSize65,
                            child: CupertinoPicker(
                                itemExtent: AppSizes.spaceSize20,
                                onSelectedItemChanged: (selected) {
                                  Provider.of<CreatePlanProvider>(context,
                                          listen: false)
                                      .setCurrencyType(selected);
                                },
                                children: [
                                  Center(
                                    child: Text(
                                      AppStrings.dollarSympol,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.syrianPound,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
