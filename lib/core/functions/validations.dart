import 'package:budgeting_app/core/utils/strings/app_strings.dart';

String? validateName(String? value) {
  if (RegExp("[a-zA-Z]").hasMatch(value!)) {
    return null;
  } else {
    return AppStrings.invalid + AppStrings.spaceString + AppStrings.name;
  }
}

String? validateSalary(String? value) {
  if (double.tryParse(value!) != null) {
    return null;
  } else {
    return AppStrings.invalid + AppStrings.spaceString + AppStrings.salary;
  }
}
