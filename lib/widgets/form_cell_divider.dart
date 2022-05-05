import 'package:flutter/material.dart';

class FormCellDivider extends StatelessWidget {
  const FormCellDivider({Key? key, this.subDivider = false}) : super(key: key);

  final bool subDivider;

  @override
  build(context) => Divider(
        height: 1,
        indent: subDivider ? 16 : null,
      );
}
