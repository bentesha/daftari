import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'form_cell.dart';
import 'form_cell_clear_icon.dart';
import 'form_cell_error.dart';
import 'form_cell_label.dart';
import 'form_cell_selector_icon.dart';
import 'form_cell_text.dart';

class DatePickerFormCell extends StatelessWidget {
  const DatePickerFormCell(
      {required this.label,
      required this.value,
      this.firstDate,
      this.lastDate,
      this.hintText,
      this.errorText,
      this.clearable = false,
      this.enabled = true,
      required this.onChanged,
      super.key});

  final String label;
  final DateTime? value;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? errorText;
  final bool clearable, enabled;
  final ValueChanged<DateTime?> onChanged;

  _showDatePicker(context) async {
    final newValue = await showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate:
            firstDate ?? DateTime.now().subtract(const Duration(days: 365)),
        lastDate: lastDate ?? DateTime.now());
    if (newValue != null && newValue != value) onChanged(newValue);
  }

  _clearValue() {
    onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    final showClearButton = clearable && value != null;
    final showSelectorButton = enabled;
    return FormCell(
        onTap: enabled ? () => _showDatePicker(context) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormCellLabel(label),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: FormCellText(
                  valueText: value != null ? Utils.dateToString(value!) : null,
                  hintText: hintText ?? 'Tap to select',
                )),
                if (showSelectorButton)
                  FormCellSelectorIcon(
                      onPressed: () => _showDatePicker(context)),
                if (showClearButton) FormCellClearIcon(onPressed: _clearValue)
              ],
            ),
            FormCellError(errorText)
          ],
        ));
  }
}
