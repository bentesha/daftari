import 'package:flutter/material.dart';

class FormCellSelectorIcon extends StatelessWidget {
  FormCellSelectorIcon({required this.onPressed});

  final VoidCallback onPressed;

  @override
  build(context) => SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.chevron_right),
          padding: EdgeInsets.zero));
}
