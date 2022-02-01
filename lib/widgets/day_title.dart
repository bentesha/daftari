import '../source.dart';

class DayTitle extends StatelessWidget {
  const DayTitle({Key? key, this.withButton = true}) : super(key: key);

  final bool withButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      color: AppColors.secondaryVariant,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DayText(),
          withButton
              ? AppIconButton(
                  onPressed: () {},
                  icon: Icons.more_horiz,
                  iconColor: AppColors.onSecondary,
                )
              : Container()
        ],
      ),
    );
  }
}
