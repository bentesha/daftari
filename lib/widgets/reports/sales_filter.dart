import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/models/option_item.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/choice_chip.dart';
import 'package:inventory_management/widgets/date_range_picker_form_cell.dart';
import 'package:inventory_management/widgets/form_cell_divider.dart';

class SalesFilterDialog extends StatefulWidget {
  const SalesFilterDialog(this.queryOptions, {Key? key}) : super(key: key);

  final QueryOptions queryOptions;

  static Future<QueryOptions?> navigateTo(
      BuildContext context, QueryOptions queryOptions) {
    return Navigator.of(context).push(MaterialPageRoute<QueryOptions>(
        builder: (context) => SalesFilterDialog(queryOptions)));
  }

  @override
  createState() => _SalesFilterDialogState();
}

class _SalesFilterDialogState extends State<SalesFilterDialog> {
  final dayField = 'dayfield',
      monthField = 'monthField',
      quarterField = 'quarterField',
      yearField = 'yearField',
      itemField = 'itemField',
      categoryField = 'categoryField';

  late final QueryOptions options;

  @override
  void initState() {
    options = widget.queryOptions.copy();
    super.initState();
  }

  _handelApply() {
    Navigator.of(context).pop(options);
  }

  _handleClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: _handleClose, icon: const Icon(Icons.close)),
            title: const Text('Sort & Filter'),
            actions: [
              TextButton(
                onPressed: _handelApply,
                child:
                    const Text('APPLY', style: TextStyle(color: Colors.white)),
              )
            ]),
        body: ListView(
          children: [
            ChoiceChipFormCell<String>(
              label: 'GROUP BY',
              value: options.sortBy,
              options: [
                OptionItem(value: dayField, label: 'Day'),
                OptionItem(value: monthField, label: 'Month'),
                OptionItem(value: quarterField, label: 'Quarter'),
                OptionItem(value: yearField, label: 'Year'),
                OptionItem(value: itemField, label: 'Item'),
                OptionItem(value: categoryField, label: 'Category'),
              ],
              onSelected: (value) => setState(() {
                options.sortBy = value;
              }),
            ),
            FormCellDivider(subDivider: true),
            ChoiceChipFormCell<SortDirection>(
                label: 'SORT DIRECTION',
                value: options.sortDirection,
                options: const [
                  OptionItem(
                      label: 'Ascending', value: SortDirection.ascending),
                  OptionItem(
                      label: 'Descending', value: SortDirection.descending)
                ],
                onSelected: (value) => setState(() {
                      options.sortDirection = value;
                    })),
            FormCellDivider(),
            DateRangePickerFormCell(
                label: 'DATE RANGE',
                value: options.getDateRange,
                clearable: true,
                onChanged: (value) {
                  setState(() {
                    options.addFilter(
                        DateRangeFilter('date_range')..value = value);
                  });
                }),
            FormCellDivider(subDivider: true),
            FormCellDivider(subDivider: true),
            ValueSelector(
                title: 'CATEGORY',
                onPressed: () async {
                  final category = await ItemsSearchPage.navigateTo<Category>(
                      context, CategoryTypes.products) as Category?;
                  options.addFilter(
                      StringFilter('category')..value = category?.name);
                },
                error: null,
                value: options.getCategory,
                isEditable: true),
            ValueSelector(
                title: 'PRODUCT',
                onPressed: () async {
                  final product =
                      await ItemsSearchPage.navigateTo<Product>(context)
                          as Product?;
                  options.addFilter(
                      StringFilter('product')..value = product?.name);
                },
                value: options.getProduct,
                error: null,
                isEditable: true),
          ],
        ));
  }
}
