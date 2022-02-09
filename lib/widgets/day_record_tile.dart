import '../source.dart';

class DayRecordTile extends StatelessWidget {
  const DayRecordTile(
      {Key? key,
      required this.date,
      required this.recordList,
      required this.dailyAmounts})
      : super(key: key);

  final DateTime date;
  final List<Record> recordList;
  final Map<int, double> dailyAmounts;

  @override
  Widget build(BuildContext context) {
    final ordinal = DateFormatter.getOrdinalsFrom(date.day);
    final weekDay = DateFormatter.getWeekDay(date.weekday);
    final dayTotalAmount = Utils.convertToMoneyFormat(dailyAmounts[date.day]!);
    final dayString = '${date.day}$ordinal, $weekDay';

    return AppTextButton(
        backgroundColor: AppColors.surface2,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    DayRecordsPage(day: date.day, title: dayString))),
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 10.dh),
        margin: EdgeInsets.only(right: 8.dw, left: 8.dw, top: 10.dh),
        child: Row(
          children: [
            AppText(dayString, color: AppColors.secondary),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [AppText(dayTotalAmount, weight: FontWeight.bold)],
            ))
          ],
        ));
  }
}
