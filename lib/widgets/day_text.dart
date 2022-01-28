import '../source.dart';

class DayText extends StatelessWidget {
  const DayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = DateTime.now().day;
    final weekDay = Utils.getWeekDay(day);
    final ordinal = Utils.getOrdinalsFrom(day);

    /*   return Padding(
      padding: EdgeInsets.only(left: 18, top: 20, bottom: 8.dh),
      child: AppText('$day$ordinal $weekDay', style: AppTextStyles.heading),
    ); */
    return AppText('$day$ordinal $weekDay', style: AppTextStyles.body2);
  }
}
