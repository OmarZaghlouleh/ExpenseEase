import 'package:budgeting_app/core/utils/durations/animation_duration.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:budgeting_app/plans/presentation/components/Create%20plan%20components/sections/plan_details_section.dart';
import 'package:budgeting_app/plans/presentation/components/Create%20plan%20components/sections/select_plan_type_section.dart';
import 'package:budgeting_app/plans/presentation/controller/create_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePlanScreen extends StatelessWidget {
  CreatePlanScreen({super.key});
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: Duration(milliseconds: AnimationDuration.d300),
            curve: Curves.linear,
          );
          if (_pageController.offset ==
              _pageController.position.maxScrollExtent) {
            final result = _formKey.currentState!.validate();
            if (result == true) {
              Provider.of<CreatePlanProvider>(context, listen: false)
                  .createPlan(
                name: _nameController.text.trim(),
                salary: _salaryController.text.trim(),
              );
            }
          }
        },
        child: const Text(AppStrings.next),
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            const SelectPlanTypeSection(),
            PlanDetailsSection(
              formKey: _formKey,
              pageController: _pageController,
              nameController: _nameController,
              salaryController: _salaryController,
            ),
          ],
        ),
      ),
    );
  }
}
