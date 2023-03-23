import 'package:budgeting_app/classes/vector.dart';
import 'package:flutter/material.dart';

Vector2 getWidgetLocation(GlobalKey widgetKey) {
  final RenderBox renderBox =
      widgetKey.currentContext?.findRenderObject() as RenderBox;

  final Size size = renderBox.size; // or _widgetKey.currentContext?.size

  final Offset offset = renderBox.localToGlobal(Offset.zero);

  return Vector2((offset.dx + size.width) / 2, offset.dy);
}
