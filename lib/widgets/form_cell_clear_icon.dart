import 'package:flutter/material.dart';
import 'package:inventory_management/themes/app_colors.dart';

class FormCellClearIcon extends StatelessWidget {
  const FormCellClearIcon({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  build(context) => SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.close, color: AppColors.onBackground),
          padding: EdgeInsets.zero));
}
