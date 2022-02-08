import '../source.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(this.record, {Key? key}) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    final item = record.item;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(item.title, weight: FontWeight.w500),
              AppText(item.getQuantityValue,
                  weight: FontWeight.w500, size: 16.dw)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${record.quantity} ${item.unit} @ ${item.getUnitPrice}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
