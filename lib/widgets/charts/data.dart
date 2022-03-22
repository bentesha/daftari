class SalesData {
  final Date date;
  final int value;

  double get month => date.month.toDouble();

  String get yearString => date.year.toString();

  double get doubleValue => value.toDouble();

  SalesData(this.date, this.value);
}

class Date {
  final int year, month;
  Date(this.year, this.month);
}

final chartData = <SalesData>[
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
