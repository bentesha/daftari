import 'package:flutter/material.dart';

class FormCellDivider extends StatelessWidget {
  FormCellDivider({this.subDivider = false});

  final bool subDivider;

  @override
  build(context) => Divider(
        height: 1,
        indent: subDivider ? 16 : null,
      );
}
