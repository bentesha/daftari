import '../source.dart';

class BottomTotalAmountTile extends StatelessWidget {
  const BottomTotalAmountTile(this.totalAmount, {Key? key}) : super(key: key);

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final formatted = Utils.convertToMoneyFormat(totalAmount);
    if (totalAmount == 0) return Container(height: .001);

    return Container(
      color: AppColors.primary,
      height: 55.dh,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText('Total Amount'.toUpperCase(), color: AppColors.onPrimary),
          AppText(formatted, size: 18.dw, color: AppColors.onPrimary),
        ],
      ),
    );
  }
}
