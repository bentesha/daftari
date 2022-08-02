import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_cell.dart';
import 'form_cell_label.dart';

class TextInputFormCell extends StatelessWidget {
  const TextInputFormCell(
      {Key? key, required this.label,
      this.controller,
      this.onChanged,
      required this.hintText,
      this.inputType,
      this.inputFormatters,
      this.textCapitalization = TextCapitalization.sentences,
      this.errorText}) : super(key: key);

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final String hintText;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return FormCell(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FormCellLabel(label),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: inputType,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
            isCollapsed: true,
            hintText: hintText,
            errorText: errorText,
            border: InputBorder.none),
      )
    ]));
  }
}
