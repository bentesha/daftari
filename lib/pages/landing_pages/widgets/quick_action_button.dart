import '../../../source.dart';

class QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const QuickActionButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      width: 180.dw,
      height: 140.dw,
      alignment: Alignment.centerLeft,
      backgroundColor: AppColors.onPrimary,
      borderRadius: BorderRadius.all(Radius.circular(10.dw)),
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, color: Colors.black54),
          AppText(label, size: 16.dw, color: AppColors.primary)
        ],
      ),
    );
  }
}
