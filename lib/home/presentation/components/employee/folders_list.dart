import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/home/presentation/components/employee/folder_card.dart';
import 'package:budgeting_app/home/presentation/controller/employee_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FoldersList extends StatelessWidget {
  const FoldersList(
      {required this.scrollController, super.key, required this.planType});

  final ScrollController scrollController;
  final PlanType planType;
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(
      builder: (context, value, child) => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          children: value.getFolders.reversed
              .map(
                (folder) => FolderCard(
                  folder: folder,
                  employeeProvider: value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
