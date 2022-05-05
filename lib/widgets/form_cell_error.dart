import 'package:flutter/material.dart';

class FormCellError extends StatelessWidget {
  const FormCellError(this.errorText, {Key? key}) : super(key: key);

  final String? errorText;

  @override
  build(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorText != null) const SizedBox(height: 8),
          if (errorText != null)
            Text(errorText!,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Theme.of(context).errorColor))
        ],
      );
}
