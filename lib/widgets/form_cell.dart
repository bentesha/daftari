import 'package:flutter/material.dart';

class FormCell extends StatelessWidget {
  FormCell({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  build(context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: child));
  }
}
