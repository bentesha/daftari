import '../../source.dart';

class InventoryMovementCard extends StatelessWidget {
  final List<Product> products;
  const InventoryMovementCard({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 15.dh),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText("Inventory Movement", size: 15.dw, weight: FontWeight.bold),
          AppText('By Product', size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          if (products.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(child: Text('No data')),
            ),
          if (products.isNotEmpty)
            ListView.builder(itemBuilder: (_, index) {
              return ListTile(
                title: Text(products[index].name),
                trailing: const Icon(Icons.arrow_right),
              );
            })
        ],
      ),
    );
  }
}
