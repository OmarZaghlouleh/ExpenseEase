import 'dart:developer';

import 'package:flutter/foundation.dart';

void debugLog({required String message}) {
  if (kDebugMode) log(message);
}

void debugPrint({required String message}) {
  if (kDebugMode) print(message);
}
