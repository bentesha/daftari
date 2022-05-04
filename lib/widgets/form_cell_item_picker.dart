import 'package:flutter/material.dart';

import 'form_cell.dart';
import 'form_cell_clear_icon.dart';
import 'form_cell_error.dart';
import 'form_cell_label.dart';
import 'form_cell_selector_icon.dart';
import 'form_cell_text.dart';

class FormCellItemPicker extends StatelessWidget {
  const FormCellItemPicker(
      {Key? key, required this.label,
      required this.valueText,
      this.clearable = false,
      this.hintText,
      this.errorText,
      required this.onPressed,
      required this.onClear}) : super(key: key);

  final String label;
  final String? valueText;
  final VoidCallback onPressed;
  final VoidCallback onClear;
  final String? hintText;
  final String? errorText;
  final bool clearable;

  @override
  Widget build(context) {
    final bool showClearButton = clearable && valueText != null;
    return FormCell(
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormCellLabel(label, hasError: errorText != null),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: FormCellText(
                      valueText: valueText,
                      hintText: hintText ?? 'Tap to select'),
                ),
                const SizedBox(width: 16),
                if (!showClearButton)
                  FormCellSelectorIcon(onPressed: onPressed),
                if (showClearButton) FormCellClearIcon(onPressed: onClear)
              ],
            ),
            FormCellError(errorText)
          ],
        ));
  }
}
