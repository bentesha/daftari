import '../source.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile(
      {Key? key,
      required this.title,
      this.description,
      required this.totalPrice})
      : super(key: key);

  final String title;
  final String? description;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.dw, vertical: 10.dh),
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
          description == null ? Container() : SizedBox(height: 5.dh),
          description == null
              ? Container()
              : AppText(
                  description!,
                  style: AppTextStyles.subtitle,
                )
        ],
      ),
    );
  }
}
