import 'package:budgeting_app/core/extensions/sizedbox_extension.dart';
import 'package:budgeting_app/core/utils/sizes/app_sizes.dart';
import 'package:budgeting_app/core/utils/sizes/padding.dart';
import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({required this.value, required this.name, super.key});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPaddings.p12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          AppSizes.spaceSize10.wh(),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
