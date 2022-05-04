import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  FormSection({required this.label});
  final String label;

  @override
  build(context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
      );
}