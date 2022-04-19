import '../../source.dart';

class PriceList extends StatelessWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const AppText('Price List')),
        body: ListView(
            children: List.generate(categories.length, (index) {
          return Container(
            margin: EdgeInsets.only(bottom: 20.dh),
            child: Column(
              children: [
                AppText(categories[index].toUpperCase(),
                    weight: FontWeight.bold),
                const AppDivider(),
                Column(
                  children: items[index]
                      .map((e) => SizedBox(
                            height: 45.dh,
                            child: ListTile(
                              title: AppText(e.name),
                              trailing: AppText(
                                  Utils.convertToMoneyFormat(e.amount),
                                  weight: FontWeight.bold,
                                  opacity: .7),
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          );
        })));
  }
}

final categories = ['Grains & Breads', 'Water', 'Dairy & Eggs', 'Oil & Fat'];

final items = [
  [
    const Product('Spaghetti', 20000),
    const Product('Noodles', 20000),
    const Product('White Bread', 1500),
    const Product('Wheat Bread', 2000),
    const Product('All Purpose Floor', 2000),
    const Product('Rice', 2300),
  ],
  [
    const Product('Kilimanjaro', 1400),
    const Product('Uhai', 600),
    const Product('Hill Water', 500),
    const Product('Masafi', 500),
  ],
  [
    const Product('Milk', 2000),
    const Product('Eggs', 24500),
    const Product('Cheese', 1500),
    const Product('Yogurt', 2000),
  ],
  [
    const Product('Cooking Oil', 8000),
    const Product('Butter', 3500),
  ],
];

class Product {
  final String name;
  final double amount;
  const Product(this.name, this.amount);
}
