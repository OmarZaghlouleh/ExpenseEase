import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.autoFocus = false,
      required this.controller,
      required this.icon,
      required this.label,
      required this.textInputType,
      required this.validation,
      super.key});

  final TextEditingController controller;
  final Widget icon;
  final String label;
  final TextInputType textInputType;
  final String? Function(String? value) validation;
  bool autoFocus = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.p15),
      child: TextFormField(
        autofocus: autoFocus,
        //key: formKey,
        validator: validation,
        keyboardType: textInputType,
        style: Theme.of(context).textTheme.labelMedium,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: label,
        ),
      ),
    );
  }
}
