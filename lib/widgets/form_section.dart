import 'package:flutter/material.dart';

class FormSection extends StatelessWidget {
  const FormSection({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  build(context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border(top: BorderSide(color: Colors.grey.shade300))),
      );
}