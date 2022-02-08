import '../source.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(
      {Key? key,
      required this.title,
      required this.actionCallback,
      required this.actionIcon})
      : super(key: key);

  final String title;
  final VoidCallback actionCallback;
  final IconData actionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryVariant,
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            title,
            color: AppColors.onSecondary.withOpacity(.85),
          ),
          AppIconButton(
            onPressed: actionCallback,
            icon: actionIcon,
          )
        ],
      ),
    );
  }
}
