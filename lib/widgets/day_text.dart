import '../source.dart';

class DayText extends StatelessWidget {
  const DayText({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final day = DateTime.now().day;
    final weekDay = DateFormatter.getWeekDay(day);
    final ordinal = DateFormatter.getOrdinalsFrom(day);

    return AppText(
      '$day$ordinal $weekDay',
      color: color ?? AppColors.onSecondary.withOpacity(.85),
    );
  }
}
