import '../source.dart';

class RecordTile extends StatelessWidget {
  const RecordTile(this.record, {Key? key}) : super(key: key);

  final Sales record;

  @override
  Widget build(BuildContext context) {
    final item = record.product;

    return AppMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 8.dh),
      isFilled: false,
      onPressed: () => push(RecordEditPage(record: record)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(item.name, weight: FontWeight.w300),
              AppText(record.formattedTotal, weight: FontWeight.bold)
            ],
          ),
          SizedBox(height: 5.dh),
          AppText('${record.quantity} ${item.unit} @ ${record.total}',
              opacity: .7, size: 14.dw)
        ],
      ),
    );
  }
}
