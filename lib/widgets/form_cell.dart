import 'package:flutter/material.dart';

class FormCell extends StatelessWidget {
  const FormCell({Key? key, required this.child, this.onTap}) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  build(context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: child));
  }
}
