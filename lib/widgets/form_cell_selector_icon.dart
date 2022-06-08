import 'package:inventory_management/source.dart';

class FormCellSelectorIcon extends StatelessWidget {
  const FormCellSelectorIcon({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(context) => SizedBox(
      child: AppIconButton(
          onPressed: onPressed,
          icon: Icons.chevron_right,
          iconThemeData: const IconThemeData(color: AppColors.onBackground),
          height: 24,
          width: 24));
}
