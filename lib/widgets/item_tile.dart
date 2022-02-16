import '../source.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item, {Key? key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => ItemEditPage(item: item))),
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      isFilled: false,
      child: ListTile(
        title: AppText(item.name),
        trailing: AppText(item.getQuantityValue, weight: FontWeight.bold),
      ),
    );
  }
}
