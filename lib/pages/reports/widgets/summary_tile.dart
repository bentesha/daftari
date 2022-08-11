import 'package:inventory_management/source.dart';

class ReportTile extends StatelessWidget {
  const ReportTile(
      {required this.name,
      required this.value,
      required this.tileColor,
      Key? key})
      : super(key: key);

  final String name;
  final num value;
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

class PriceListReportTile extends StatelessWidget {
  const PriceListReportTile(
      {required this.product, required this.tileColor, Key? key})
      : super(key: key);

  final Product product;
  final Color tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileColor,
      height: 45.dh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15.dw),
              child: AppText(product.name,
                  color: AppColors.onBackground, weight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: 75,
            child: Center(
              child: AppText(product.unit,
                  color: AppColors.onBackground, weight: FontWeight.w400),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 15.dw),
              child: AppText(Utils.convertToMoneyFormat(product.unitPrice),
                  color: AppColors.onBackground2, weight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
