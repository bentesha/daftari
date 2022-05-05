import 'package:inventory_management/widgets/report_title.dart';

import '../../source.dart';

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReportTitle(title1: 'item', title2: 'price'),
        Expanded(
          child: ListView(
              padding: EdgeInsets.only(bottom: 20.dh),
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
                          children: items[index]
                              .map((e) => SizedBox(
                                    height: 45.dh,
                                    child: ListTile(
                                      title: AppText(e.name,
                                          color: AppColors.onBackground2),
                                      trailing: AppText(
                                          Utils.convertToMoneyFormat(e.amount),
                                          weight: FontWeight.bold,
                                          opacity: .7),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                );
              })),
        ),
      ],
    );
  }
}

final categories = ['Grains & Breads', 'Water', 'Dairy & Eggs', 'Oil & Fat'];

final items = [
  [
    const Item('Spaghetti', 20000),
    const Item('Noodles', 20000),
    const Item('White Bread', 1500),
    const Item('Wheat Bread', 2000),
    const Item('All Purpose Floor', 2000),
    const Item('Rice', 2300),
  ],
  [
    const Item('Kilimanjaro', 1400),
    const Item('Uhai', 600),
    const Item('Hill Water', 500),
    const Item('Masafi', 500),
  ],
  [
    const Item('Milk', 2000),
    const Item('Eggs', 24500),
    const Item('Cheese', 1500),
    const Item('Yogurt', 2000),
  ],
  [
    const Item('Cooking Oil', 8000),
    const Item('Butter', 3500),
  ],
];

class Item {
  final String name;
  final double amount;
  const Item(this.name, this.amount);
}
