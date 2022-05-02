import 'package:inventory_management/source.dart';

class RemainingStockReport extends StatelessWidget {
  const RemainingStockReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitles(),
        Expanded(
          child: ListView(
              padding: EdgeInsets.only(bottom: 20.dh),
              shrinkWrap: true,
              children: List.generate(categories.length, (index) {
                return Container(
                  margin: EdgeInsets.only(top: 20.dh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.dw),
                        child: AppText(categories[index].toUpperCase(),
                            weight: FontWeight.w500),
                      ),
                      const AppDivider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.dw),
                        child: Column(
                          children: stockItems[index]
                              .map((e) => SizedBox(
                                    height: 45.dh,
                                    child: ListTile(
                                      title: AppText(e.name, color: AppColors.onBackground2),
                                      trailing: AppText(e.amount.toString(),
                                          weight: FontWeight.bold, opacity: .7),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                );
              })),
        )
      ],
    );
  }

  _buildTitles() {
    return Container(
      color: AppColors.surface,
      height: 50.dh,
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15.dw),
                  child: AppText('PRODUCT',
                      size: 16.dw, weight: FontWeight.bold))),
          Expanded(
              child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 15.dw),
                  child: AppText('IN STOCK',
                      size: 16.dw, weight: FontWeight.bold))),
        ],
      ),
    );
  }
}

final categories = ['Grains & Breads', 'Water', 'Dairy & Eggs', 'Oil & Fat'];

final stockItems = [
  [
    const Item('Spaghetti', 2),
    const Item('Noodles', 4),
    const Item('White Bread', 20),
    const Item('Wheat Bread', 1),
    const Item('All Purpose Floor', 34),
    const Item('Rice', 12),
  ],
  [
    const Item('Kilimanjaro', 34),
    const Item('Uhai', 24),
    const Item('Hill Water', 12),
    const Item('Masafi', 500),
  ],
  [
    const Item('Milk', 11),
    const Item('Eggs', 12),
    const Item('Cheese', 12),
    const Item('Yogurt', 45),
  ],
  [
    const Item('Cooking Oil', 12),
    const Item('Butter', 15),
  ],
];

class Item {
  final String name;
  final int amount;
  const Item(this.name, this.amount);
}
