import 'package:inventory_management/source.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile(
      {this.title, required this.name, required this.value, Key? key})
      : super(key: key);

  final String? title;
  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: title == null ? 50.dh : 55.dh,
      padding: EdgeInsets.symmetric(horizontal: 15.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: title == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceAround,
        children: [
          title != null
              ? AppText(title!, color: AppColors.primaryVariant)
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(name,
                  color: AppColors.onBackground, weight: FontWeight.w400),
              AppText(Utils.convertToMoneyFormat(value),
                  color: AppColors.onBackground2, weight: FontWeight.w500)
            ],
          )
        ],
      ),
    );
  }
}
