import '../source.dart';

class MonthlyTotalTile extends StatelessWidget {
  const MonthlyTotalTile({required this.title, required this.amount, Key? key})
      : super(key: key);

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final amount = Utils.convertToMoneyFormat(this.amount);

    return Container(
      color: AppColors.secondary,
      width: ScreenSizeConfig.getFullWidth - 30.dw,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: AppTextButton(
              onPressed: () {},
              height: 60.dh,
              padding: EdgeInsets.symmetric(horizontal: 15.dw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(title,
                      style: AppTextStyles.subtitle.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.75))),
                  AppText(amount,
                      style: AppTextStyles.body.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary))
                ],
              ),
            ),
          ),
          AppDivider(height: 40.dh, width: 2.dw),
          Expanded(
            child: AppTextButton(
                onPressed: () {},
                height: 60.dh,
                child: Icon(
                  Icons.add,
                  size: 24.dw,
                  color: AppColors.onSecondary,
                )),
          )
        ],
      ),
    );
  }
}
