import 'package:flutter/material.dart';
import 'package:inventory_management/utils/screen_size_config.dart';

class FormCellLabel extends StatelessWidget {
  const FormCellLabel(this.label, {Key? key, this.hasError = false})
      : super(key: key);

  final String label;
  final bool hasError;

  @override
  build(context) => Text(label.toUpperCase(),
      style: Theme.of(context).textTheme.overline?.copyWith(
          color: hasError ? Theme.of(context).errorColor : null,
          fontSize: 12.dw));
}
