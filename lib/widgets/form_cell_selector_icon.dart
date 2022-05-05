import 'package:inventory_management/source.dart';

class FormCellSelectorIcon extends StatelessWidget {
  const FormCellSelectorIcon({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(context) => SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.chevron_right, color: AppColors.onBackground),
          padding: EdgeInsets.zero));
}
