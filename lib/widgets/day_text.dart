import '../source.dart';

class DayText extends StatelessWidget {
  const DayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = DateTime.now().day;
    final weekDay = Utils.getWeekDay(day);
    final ordinal = Utils.getOrdinalsFrom(day);

    return AppText('$day$ordinal $weekDay',
        color: AppColors.onSecondary.withOpacity(.85),
       );
  }
}
