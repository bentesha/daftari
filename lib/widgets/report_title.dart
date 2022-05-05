import 'package:inventory_management/source.dart';

class ReportTitle extends StatelessWidget {
  const ReportTitle({Key? key, required this.title1, required this.title2})
      : super(key: key);

  final String title1, title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      height: 50.dh,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.dw),
                  child: AppText(title1.toUpperCase(),
                      size: 16.dw, weight: FontWeight.bold))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.dw),
                  child: AppText(title2.toUpperCase(),
                      size: 16.dw, weight: FontWeight.bold))),
        ],
      ),
    );
  }
}
