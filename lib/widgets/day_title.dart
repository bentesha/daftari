import '../source.dart';

class DayTitle extends StatelessWidget {
  const DayTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryVariant,
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const DayText(),
          AppIconButton(
            onPressed: () {},
            icon: Icons.more_horiz,
            iconColor: AppColors.onPrimary,
          )
        ],
      ),
    );
  }
}
