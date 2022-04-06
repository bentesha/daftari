import 'package:inventory_management/widgets/app_data_table.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../source.dart';

class BreakDownDataTable extends StatelessWidget {
  const BreakDownDataTable({Key? key}) : super(key: key);

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
