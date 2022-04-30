import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../source.dart';

class BreakDownDataTable extends StatelessWidget {
  const BreakDownDataTable(this.isRevenueList, {Key? key}) : super(key: key);

  final bool isRevenueList;

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      columns: _columns,
      source: DataSource(isRevenueList),
      horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
      frozenColumnsCount: 1,
      defaultColumnWidth: ScreenSizeConfig.getFullWidth / 2,
      selectionMode: SelectionMode.singleDeselect,
    );
  }

  List<GridColumn> get _columns => List.generate(labels.length, (index) {
        final label = labels[index];
        return GridColumn(
            columnName: label,
            columnWidthMode: ColumnWidthMode.fill,
            label: Container(
              alignment:
                  index == 0 ? Alignment.centerLeft : Alignment.centerRight,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 2))),
              padding: EdgeInsets.only(left: 15.dw, right: 15.dw),
              child: AppText(label.toUpperCase(),
                  style: TextStyle(
                      fontFamily: kFontFam,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.dw,
                      color: AppColors.onBackground)),
            ));
      });
}

class DataSource extends DataGridSource {
  final bool isRevenueList;
  DataSource(this.isRevenueList);

  @override
  List<DataGridRow> get rows => (isRevenueList ? revenue : data)
      .map<DataGridRow>((expense) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: 'Category', value: expense.category),
            DataGridCell<String>(
                columnName: 'Amount',
                value: Utils.convertToMoneyFormat(expense.amount)),
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
            padding: EdgeInsets.only(left: 15.dw, right: 15.dw),
            child: AppText(e.value, size: 14.5.dw)))
        .toList();
  }
}

const labels = ['Category', 'Amount'];

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

//dimensions
final expenseCategories = [
  'Electricity',
  'Water',
  'Salaries',
  'Equipments',
  'Maintenance & Repair',
  'Advertising & Marketing',
  'Bank fees & Internet',
  'Commissions',
  'Employee Benefits',
  'Telephone & Internet',
  'Business Insurance',
  'Vacation'
];

final incomeCategories = [
  'Water',
  'Breads',
  'Detergents',
  'Soft Drinks',
  'Alcohol',
  'Stationaries',
  'Milk',
  'Rice',
  'Cooking Oil',
  'Pasta',
  'Eggs',
  'Sugar'
];

final date = [
  '1/4/2022',
  '2/4/202',
  '3/4/2022',
  '4/4/202',
  '7/4/2022',
  '8/4/202',
  '9/4/2022',
  '15/4/202',
  '17/4/2022',
  '20/4/202',
  '25/4/2022',
  '30/4/202'
];

final products = [
  'Hill Water 1L',
  'Kilimanjaro Water 1/2L.',
];
