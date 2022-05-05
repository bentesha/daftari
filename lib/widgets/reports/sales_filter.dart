import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/models/option_item.dart';
import 'package:inventory_management/models/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/choice_chip.dart';
import 'package:inventory_management/widgets/date_range_picker_form_cell.dart';
import 'package:inventory_management/widgets/form_cell_divider.dart';
import 'package:inventory_management/widgets/form_cell_item_picker.dart';

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
  final dayOption = 'day',
      monthOption = 'month',
      quarterOption = 'quarter',
      yearOption = 'year',
      itemOption = 'item',
      categoryOption = 'category';

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
            title: AppText('Sort & Filter',
                color: AppColors.onPrimary,
                weight: FontWeight.bold,
                size: 20.dw),
            actions: [
              TextButton(
                  onPressed: _handelApply,
                  child:
                      AppText('APPLY', color: AppColors.onPrimary, size: 16.dw))
            ]),
        body: ListView(
          children: [
            ChoiceChipFormCell<String>(
              label: 'GROUP BY',
              value: options.groupBy,
              options: [
                OptionItem(value: dayOption, label: 'Day'),
                OptionItem(value: monthOption, label: 'Month'),
                OptionItem(value: quarterOption, label: 'Quarter'),
                OptionItem(value: yearOption, label: 'Year'),
                OptionItem(value: itemOption, label: 'Item'),
                OptionItem(value: categoryOption, label: 'Category'),
              ],
              onSelected: (value) => setState(() {
                options.groupBy = value;
              }),
            ),
            const FormCellDivider(subDivider: true),
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
            const FormCellDivider(),
            DateRangePickerFormCell(
                label: 'DATE RANGE',
                value: (options['date_range'] as DateRangeFilter?)?.value,
                clearable: true,
                onChanged: (value) {
                  options
                      .addFilter(DateRangeFilter('date_range')..value = value);
                  setState(() {});
                }),
            const FormCellDivider(subDivider: true),
            FormCellItemPicker(
                label: 'CATEGORY',
                valueText:
                    (options['category'] as CategoryFilter?)?.value?.name,
                clearable: true,
                onPressed: () async {
                  final category = await ItemsSearchPage.navigateTo<Category>(
                      context, CategoryTypes.products) as Category?;
                  options
                      .addFilter(CategoryFilter('category')..value = category);
                  setState(() {});
                },
                onClear: () {
                  options.removeFilter('category');
                  setState(() {});
                }),
            const FormCellDivider(subDivider: true),
            FormCellItemPicker(
                label: 'PRODUCT',
                valueText: (options['product'] as ProductFilter?)?.value?.name,
                clearable: true,
                onPressed: () async {
                  final product =
                      await ItemsSearchPage.navigateTo<Product>(context)
                          as Product?;
                  options.addFilter(ProductFilter('product')..value = product);
                  setState(() {});
                },
                onClear: () {
                  options.removeFilter('product');
                  setState(() {});
                }),
          ],
        ));
  }
}
