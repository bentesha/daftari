import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../source.dart';

class BreakDownDataTable extends StatelessWidget {
  const BreakDownDataTable(this.isRevenueList, {Key? key}) : super(key: key);

  final bool isRevenueList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ScreenSizeConfig.getFullHeight,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SfDataGrid(
              columns: _columns,
              source: DataSource(),
              frozenColumnsCount: 1,
              selectionMode: SelectionMode.singleDeselect,
            )));
  }

  List<GridColumn> get _columns => List.generate(labels.length, (index) {
        final label = labels[index];
        return GridColumn(
            columnName: label,
            columnWidthMode: ColumnWidthMode.auto,
            label: Container(
              alignment: index == 0 ? Alignment.center : Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10.dw),
              child: AppText(label,
                  style: const TextStyle(
                      fontFamily: kFontFam2, fontWeight: FontWeight.bold)),
            ));
      });
}

class DataSource extends DataGridSource {
  @override
  List<DataGridRow> get rows => data
      .map<DataGridRow>((expense) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'Amount',
                value: Utils.convertToMoneyFormat(expense.amount)),
            DataGridCell<String>(
                columnName: 'Category', value: expense.category),
            DataGridCell<String>(columnName: 'Date', value: expense.date),
          ]))
      .toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: _cells(row));
  }

  List<Widget> _cells(DataGridRow row) {
    return row
        .getCells()
        .map<Widget>((e) => Container(
            alignment: e.columnName == 'Amount'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: 10.dw, right: e.columnName == 'Amount' ? 10.dw : 0),
            child: AppText(e.value, size: 14.5.dw)))
        .toList();
  }
}

const labels = ['Amount', 'Category', 'Date'];

class Expenses {
  final String category, date;
  final double amount;

  const Expenses(
      {required this.category, required this.amount, required this.date});
}

final data = <Expenses>[
  const Expenses(category: 'Electricity', amount: 20000, date: '1/4/2022'),
  const Expenses(category: 'Water', amount: 33008500, date: '2/4/2022'),
  const Expenses(category: 'Salaries', amount: 343300, date: '1/4/2022'),
  const Expenses(category: 'Equipments', amount: 78900, date: '3/4/2022'),
  const Expenses(
      category: 'Maintenance & Repair', amount: 55600, date: '4/4/2022'),
  const Expenses(
      category: 'Advertising and Marketing', amount: 334000, date: '4/4/2022'),
  const Expenses(
      category: 'Bank fees and Interest', amount: 435000, date: '5/4/2022'),
  const Expenses(category: 'Commissions', amount: 55000, date: '5/4/2022'),
  const Expenses(
      category: 'Employee Benefits', amount: 435600, date: '5/4/2022'),
  const Expenses(
      category: 'Telephone and Internet', amount: 345700, date: '6/4/2022'),
  const Expenses(category: 'Electricity', amount: 221800, date: '7/4/2022'),
  const Expenses(
      category: 'Business Insurance', amount: 45000, date: '16/4/2022'),
];

final revenue = <Expenses>[
  const Expenses(category: 'Water', amount: 20000, date: '1/4/2022'),
  const Expenses(category: 'Breads', amount: 33008500, date: '2/4/2022'),
  const Expenses(category: 'Detergents', amount: 343300, date: '1/4/2022'),
  const Expenses(category: 'Soft Drinks', amount: 78900, date: '3/4/2022'),
  const Expenses(category: 'Alcohol', amount: 55600, date: '4/4/2022'),
  const Expenses(category: 'Stationaries', amount: 334000, date: '4/4/2022'),
  const Expenses(category: 'Milk', amount: 435000, date: '5/4/2022'),
  const Expenses(category: 'Rice', amount: 55000, date: '5/4/2022'),
  const Expenses(category: 'Cooking Oil', amount: 435600, date: '5/4/2022'),
  const Expenses(category: 'Pasta', amount: 345700, date: '6/4/2022'),
  const Expenses(category: 'Eggs', amount: 221800, date: '7/4/2022'),
  const Expenses(category: 'Sugar', amount: 45000, date: '16/4/2022'),
];
