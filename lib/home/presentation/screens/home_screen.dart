// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/home/presentation/components/business_component.dart';
import 'package:budgeting_app/home/presentation/components/employee_component.dart';
import 'package:budgeting_app/home/presentation/controller/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<HomeProvider>(context, listen: false)
          .initPlan(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, child) {
      if (value.getPlanType == PlanType.employee)
        return const EmployeePlanComponent();
      else if (value.getPlanType == PlanType.business)
        return const BusinessPlanComponent();
      return Container();
    });
  }
}
