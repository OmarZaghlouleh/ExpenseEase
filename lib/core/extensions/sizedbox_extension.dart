import 'package:flutter/material.dart';

extension SizedboxExtension on num {
  Widget wh() => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );
}
