import 'package:budgeting_app/core/utils/enums.dart';
import 'package:budgeting_app/core/utils/strings/app_strings.dart';

double getPercent({required double total, required double current}) {
  return (current / total);
}

int getPercentInHundred({required double total, required double current}) {
  return ((current / total) * 100).toInt();
}

String getCurrencySympol(CurrencyType currency) {
  switch (currency) {
    case CurrencyType.dollar:
      return AppStrings.dollarSympol;

    case CurrencyType.syrianPound:
      return AppStrings.syrianPound;
    case CurrencyType.none:
      return AppStrings.emptyString;
  }
}
