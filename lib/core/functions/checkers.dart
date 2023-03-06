// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:budgeting_app/core/error/error_model.dart';
import 'package:budgeting_app/core/error/local_exception.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';
import 'package:hive/hive.dart';

void checkIfNameExist(String name, Box box) async {
  for (int i = 0; i < box.values.length; i++) {
    if (jsonDecode(box.values.toList()[i].toString())['name'] == name)
      throw LocalException(
          errorModel:
              ErrorModel(message: AppStrings.getMatchedNameErrorMessage(name)));
  }
}
