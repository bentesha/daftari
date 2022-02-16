import '../source.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(this.record, {Key? key}) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    final item = record.item;

    return AppTextButton(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      isFilled: false,
      onPressed: () => _onPressed(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(item.name, weight: FontWeight.w300),
              AppText(record.getFormattedTotalAmount,
                  weight: FontWeight.w500, size: 16.dw)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${record.quantity} ${item.unit} @ ${record.getSellingPrice}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }

  _onPressed(BuildContext context) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => RecordEditPage(record: record)));
}
