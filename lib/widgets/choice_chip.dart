import 'package:flutter/material.dart';
import 'package:inventory_management/models/option_item.dart';
import 'form_cell.dart';
import 'form_cell_error.dart';
import 'form_cell_label.dart';

class ChoiceChipFormCell<T> extends StatelessWidget {
  const ChoiceChipFormCell(
      {required this.label,
      required this.value,
      required this.options,
      this.errorText,
      required this.onSelected,
      Key? key})
      : super(key: key);

  final String label;
  final T? value;
  final List<OptionItem<T>> options;
  final String? errorText;
  final ValueChanged<T> onSelected;

  @override
  build(context) {
    return FormCell(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormCellLabel(label, hasError: errorText != null),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: options
              .map((option) => FilterChip(
                  label: Text(option.label),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w400),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  selected: option.value == value,
                  onSelected: (_) => onSelected(option.value)))
              .toList(),
        ),
        FormCellError(errorText)
      ],
    ));
  }
}
