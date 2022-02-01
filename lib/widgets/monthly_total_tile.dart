import '../source.dart';

class MonthlyTotalTile extends StatelessWidget {
  const MonthlyTotalTile(
      {required this.title,
      required this.amount,
      Key? key,
      required this.addCallback})
      : super(key: key);

  final String title;
  final double amount;
  final VoidCallback addCallback;

  @override
  Widget build(BuildContext context) {
    final amount = Utils.convertToMoneyFormat(this.amount);

    return Container(
      width: ScreenSizeConfig.getFullWidth - 30.dw,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: AppTextButton(
              isFilled: false,
              onPressed: () {},
              height: 50.dh,
              padding: EdgeInsets.symmetric(horizontal: 15.dw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title, color: AppColors.onPrimary),
                  AppText(
                    amount,
                    color: AppColors.onPrimary,
                    weight: FontWeight.w600,
                  )
                ],
              ),
            ),
          ),
          AppDivider(height: 30.dh, width: 2.dw),
          Expanded(
            child: AppTextButton(
                onPressed: addCallback,
                isFilled: false,
                height: 50.dh,
                child: Icon(
                  Icons.add,
                  size: 24.dw,
                  color: AppColors.onPrimary,
                )),
          )
        ],
      ),
    );
  }
}
