import 'package:flutter/material.dart';

class FormCellText extends StatelessWidget {

  FormCellText({
    this.valueText,
    required this.hintText
  });

  final String hintText;
  final String? valueText;

  @override
  build(context) {
    final textTheme = Theme.of(context).textTheme;
    return valueText != null
        ? Text(valueText!, style: textTheme.bodyText1)
        : Text(hintText,
            style: textTheme.bodyText2
                ?.copyWith(color: Theme.of(context).hintColor));
  }
}
