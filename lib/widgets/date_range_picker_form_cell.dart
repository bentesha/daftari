import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'form_cell.dart';
import 'form_cell_clear_icon.dart';
import 'form_cell_error.dart';
import 'form_cell_label.dart';
import 'form_cell_selector_icon.dart';
import 'form_cell_text.dart';

class DateRangePickerFormCell extends StatelessWidget {
  const DateRangePickerFormCell(
      {Key? key,
      required this.label,
      required this.value,
      this.firstDate,
      this.lastDate,
      this.hintText,
      this.clearable = false,
      this.errorText,
      required this.onChanged})
      : super(key: key);

  final String label;
  final DateTimeRange? value;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final String? errorText;
  final bool clearable;
  final ValueChanged<DateTimeRange?> onChanged;

  _showDatePicker(BuildContext context) async {
    final range = await showDateRangePicker(
        context: context,
        initialDateRange: value,
        firstDate:
            firstDate ?? DateTime.now().subtract(const Duration(days: 365)),
        lastDate: lastDate ?? DateTime.now());
    if (range != null) onChanged(range);
  }

  _clearValue() {
    onChanged(null);
  }

  @override
  build(context) {
    final showClearButton = clearable && value != null;
    final showSelectorButton = !showClearButton;
    return FormCell(
        onTap: () => _showDatePicker(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormCellLabel(label),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: FormCellText(
                  valueText:
                      value != null ? Utils.dateRangeToString(value!) : null,
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
