import 'dart:developer';

import 'package:budgeting_app/core/functions/box_functions.dart';
import 'package:budgeting_app/core/services/service_locator.dart';
import 'package:budgeting_app/core/widgets/dialogs/error_dialog.dart';
import 'package:budgeting_app/home/domain/usecases/get_business_plan_details.usecase.dart';
import 'package:budgeting_app/plans/data/models/business_plan_model.dart';
import 'package:flutter/material.dart';

class BusinessProvider extends ChangeNotifier {
  BusinessPlanModel _businessPlanModel = BusinessPlanModel.empty();

  void setBusinessPlanModel({required BuildContext context}) {
    log("Setting business");

    final result =
        getIt<GetBusinessPlanDetailsUsecase>().call(getLastPlanName());
    result.fold((l) {
      log("Set Business Error");

      showErrorDialog(context: context, message: l.message);
    }, (data) {
      _businessPlanModel = data;
      notifyListeners();
    });
  }

  BusinessPlanModel get getBusinessPlanModel => _businessPlanModel;
}
