import '../source.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(
      {Key? key,
      required this.title,
      required this.unit,
      required this.totalPrice,
      required this.unitPrice,
      required this.quantity})
      : super(key: key);

  final String title, unit;
  final double totalPrice, unitPrice, quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title,
                  style: AppTextStyles.body2
                      .copyWith(color: AppColors.onBackground)),
              AppText(
                Utils.convertToMoneyFormat(totalPrice),
                style: AppTextStyles.body,
              )
            ],
          ),
          SizedBox(height: 5.dh),
          AppText(
            '$quantity $unit @ ${Utils.convertToMoneyFormat(unitPrice)}',
            style: AppTextStyles.subtitle,
          )
        ],
      ),
    );
  }
}
