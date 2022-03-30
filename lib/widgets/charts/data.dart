class SalesData {
  final Date date;
  final int value;

  double get month => date.month.toDouble();

  String get yearString => date.year.toString();

  double get doubleValue => value.toDouble();

  String get percent => '${(value / 7025585 * 100).toInt()} %';

  const SalesData(this.date, this.value);
}

class ItemData {
  final Item item;
  final int value;
  const ItemData(this.item, this.value);

  String get percent => '${(value / 6725360 * 100).toInt()} %';

  double get doublePercent => value / 6725360;
}

class Date {
  final int year, month;
  const Date(this.year, this.month);
}

class Item {
  final String name;
  const Item(this.name);
}

const itemData = <ItemData>[
  ItemData(Item('Bread'), 760000),
  ItemData(Item('Soda'), 880560),
  ItemData(Item('Water'), 788000),
  ItemData(Item('Detergents'), 560300),
  ItemData(Item('Stationeries'), 566750),
  ItemData(Item('Rice'), 650000),
  ItemData(Item('Alcohol'), 750200),
  ItemData(Item('Other'), 760450),
  ItemData(Item('Milk'), 220540),
  ItemData(Item('Electrical Supplies'), 788560),
];

const expenseData = <ItemData>[
  ItemData(Item('Electricity'), 566400),
  ItemData(Item('Rent'), 102250),
  ItemData(Item('Water'), 800000),
  ItemData(Item('Insurance'), 450050),
  ItemData(Item('Tax'), 120040),
  ItemData(Item('Commissions & Fees'), 663000),
  ItemData(Item('Advertising'), 760000),
  ItemData(Item('Equipment Rentals'), 680500),
  ItemData(Item('Travel'), 560300),
  ItemData(Item('Meals'), 200040),
  ItemData(Item('Software'), 650000),
  ItemData(Item('Utilities'), 300225)
];

List<ItemData> getItems() {
  final list = List.from(expenseData).whereType<ItemData>().toList();
  list.sort((a, b) => a.value.compareTo(b.value));
  final reversed = list.reversed.toList();
  return reversed;
}

List<ItemData> getRevenueItems() {
  var list = List.from(itemData).whereType<ItemData>().toList();
  list.sort((a, b) => a.value.compareTo(b.value));
  final reversed = list.reversed.toList();
  return reversed;
}

const chartData = <SalesData>[
  SalesData(Date(2005, 01), 760000),
  SalesData(Date(2006, 02), 880560),
  SalesData(Date(2007, 03), 788000),
  SalesData(Date(2008, 04), 560300),
  SalesData(Date(2009, 05), 566750),
  SalesData(Date(2010, 06), 650000),
  SalesData(Date(2011, 07), 750200),
  SalesData(Date(2012, 08), 760450),
  SalesData(Date(2013, 09), 220540),
  SalesData(Date(2014, 10), 788560),
  SalesData(Date(2015, 11), 300225),
/*  SalesData(Date(2016, 12), 566400),
  SalesData(Date(2017, 13), 102250),
  SalesData(Date(2018, 14), 800000),
  SalesData(Date(2019, 15), 450050),
  SalesData(Date(2020, 16), 120040),
  SalesData(Date(2021, 17), 663000),
  SalesData(Date(2022, 18), 760000),
  SalesData(Date(2023, 19), 680500),
  SalesData(Date(2024, 20), 560300),
  SalesData(Date(2025, 21), 200040),
  SalesData(Date(2026, 22), 650000),
  SalesData(Date(2027, 23), 300225)*/
];
