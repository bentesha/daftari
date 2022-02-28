import '../source.dart';

class WriteOffTile extends StatelessWidget {
  const WriteOffTile(this.writeOff, {Key? key}) : super(key: key);

  final WriteOff writeOff;

  @override
  Widget build(BuildContext context) {
    return AppMaterialButton(
        isFilled: false,
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        child: ListTile(
            title: AppText(writeOff.product.name),
            trailing: AppText(writeOff.quantity.toString(), weight: FontWeight.bold)),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => WriteOffEditPage(writeOff: writeOff))));
  }
}
