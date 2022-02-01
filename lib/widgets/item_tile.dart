import '../source.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.itemTitle, {Key? key, required this.onPressed})
      : super(key: key);

  final String itemTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      margin: EdgeInsets.only(bottom: 10.dh),
      padding: EdgeInsets.only(bottom: 10.dh),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(19.dw, 10.dh, 19.dw, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(itemTitle, weight: FontWeight.w500, size: 18.dw),
              AppIconButton(
                onPressed: onPressed,
                icon: Icons.more_horiz,
                iconColor: AppColors.primaryVariant,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.dh),
          child: Container(height: 1.dh, color: Colors.grey),
        ),
        _buildItemDetail('Unit', 'kgs.'),
        _buildItemDetail('In Stock', '20'),
        _buildItemDetail('Value', Utils.convertToMoneyFormat(30000)),
      ]),
    );
  }

  _buildItemDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(title, opacity: .75, size: 15.dw),
          AppText(value, weight: FontWeight.w500, size: 15.dw),
        ],
      ),
    );
  }
}
