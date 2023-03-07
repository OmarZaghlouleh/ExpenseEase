// ignore_for_file: use_build_context_synchronously

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
        onPressed: () async {
          await Provider.of<CreatePlanProvider>(context, listen: false)
              .nextFunction(
                  pageController: _pageController,
                  formKey: _formKey,
                  context: context,
                  nameController: _nameController,
                  salaryController: _salaryController);
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
