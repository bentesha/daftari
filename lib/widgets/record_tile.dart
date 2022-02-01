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
              AppText(title, weight: FontWeight.w500),
              AppText(Utils.convertToMoneyFormat(totalPrice),
                  weight: FontWeight.w500, size: 16.dw)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('$quantity $unit @ ${Utils.convertToMoneyFormat(unitPrice)}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
