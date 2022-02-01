import '../source.dart';

class AdjustableTile extends StatelessWidget {
  const AdjustableTile(
      {Key? key,
      required this.title,
      this.description,
      this.date,
      required this.totalPrice})
      : super(key: key);

  final String title;
  final String? description, date;
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
          _buildText(description),
          _buildText(date)
        ],
      ),
    );
  }

  _buildText(String? text) {
    final isEmpty = text == null;
    return Padding(
      padding: isEmpty ? EdgeInsets.zero : EdgeInsets.only(top: 5.dh),
      child:
          isEmpty ? Container() : AppText(text, style: AppTextStyles.subtitle),
    );
  }
}
