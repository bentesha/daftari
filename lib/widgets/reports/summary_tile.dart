import 'package:inventory_management/source.dart';

class ReportTile extends StatelessWidget {
  const ReportTile(
      {required this.name,
      required this.value,
      required this.tileColor,
      Key? key})
      : super(key: key);

  final String name;
  final double value;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileColor,
      height: 45.dh,
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(name, color: AppColors.onBackground, weight: FontWeight.w400),
          AppText(Utils.convertToMoneyFormat(value),
              color: AppColors.onBackground2, weight: FontWeight.w500)
        ],
      ),
    );
  }
}
