import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/models/option_item.dart';
import 'package:inventory_management/blocs/filter/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/choice_chip.dart';
import 'package:inventory_management/widgets/date_range_picker_form_cell.dart';
import 'package:inventory_management/widgets/form_cell_divider.dart';
import 'package:inventory_management/widgets/form_cell_item_picker.dart';

class SalesFilterDialog extends StatefulWidget {
  const SalesFilterDialog({Key? key}) : super(key: key);

  ///returns true if the filters were edited.
  static Future<bool?> navigateTo(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute<bool>(
        builder: (context) => const SalesFilterDialog()));
  }

  @override
  createState() => _SalesFilterDialogState();
}

class _SalesFilterDialogState extends State<SalesFilterDialog> {
  late final QueryFiltersBloc options;

  @override
  void initState() {
    options = BlocProvider.of<QueryFiltersBloc>(context, listen: false);
    super.initState();
  }

  _handelApply() {
    Navigator.of(context).pop(true);
  }

  _handleClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(context) {
    return BlocBuilder<QueryFiltersBloc, List<QueryFilter>>(
        builder: (context, filters) {
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
                    child: AppText('APPLY',
                        color: AppColors.onPrimary, size: 16.dw))
              ]),
          body: ListView(
            children: [
              ChoiceChipFormCell<GroupBy>(
                  label: 'GROUP BY',
                  value: (options['groupBy'] as GroupByFilter).value,
                  options: const [
                    OptionItem(value: GroupBy.day, label: 'Day'),
                    OptionItem(value: GroupBy.month, label: 'Month'),
                    OptionItem(value: GroupBy.quarter, label: 'Quarter'),
                    OptionItem(value: GroupBy.year, label: 'Year'),
                    OptionItem(value: GroupBy.product, label: 'Product'),
                    OptionItem(value: GroupBy.category, label: 'Category'),
                  ],
                  onSelected: (value) =>
                      options.addFilter<GroupBy>('groupBy', value)),
              const FormCellDivider(subDivider: true),
              ChoiceChipFormCell<SortBy>(
                  label: 'SORT BY',
                  value: (options['sortBy'] as SortByFilter).value,
                  options: const [
                    OptionItem(label: 'Dimension', value: SortBy.dimension),
                    OptionItem(label: 'Metric', value: SortBy.metric)
                  ],
                  onSelected: (value) =>
                      options.addFilter<SortBy>('sortBy', value)),
              const FormCellDivider(subDivider: true),
              ChoiceChipFormCell<SortDirection>(
                  label: 'SORT DIRECTION',
                  value: (options['sortDirection'] as SortDirFilter).value,
                  options: const [
                    OptionItem(
                        label: 'Ascending', value: SortDirection.ascending),
                    OptionItem(
                        label: 'Descending', value: SortDirection.descending)
                  ],
                  onSelected: (value) =>
                      options.addFilter<SortDirection>('sortDirection', value)),
              const FormCellDivider(),
              DateRangePickerFormCell(
                  label: 'DATE RANGE',
                  value: options['date_range']?.value,
                  clearable: true,
                  onChanged: (value) =>
                      options.addFilter<DateTimeRange>('date_range', value)),
              const FormCellDivider(subDivider: true),
              FormCellItemPicker(
                  label: 'CATEGORY',
                  valueText:
                      (options['category'] as CategoryFilter?)?.value.name,
                  clearable: true,
                  onPressed: () async {
                    final category = await ItemsSearchPage.navigateTo<Category>(
                        context,
                        categoryType: CategoryTypes.products);
                    options.addFilter<Category>('category', category);
                  },
                  onClear: () => options.removeFilter('category')),
              const FormCellDivider(subDivider: true),
              FormCellItemPicker(
                  label: 'PRODUCT',
                  valueText: (options['product'] as ProductFilter?)?.value.name,
                  clearable: true,
                  onPressed: () async {
                    final product =
                        await ItemsSearchPage.navigateTo<Product>(context);
                    options.addFilter<Product>('product', product);
                  },
                  onClear: () => options.removeFilter('product')),
            ],
          ));
    });
  }

  String _getDimensionSortDir() {
    final filtersBloc = BlocProvider.of<QueryFiltersBloc>(context);
    final groupBy = (filtersBloc['groupBy'] as GroupByFilter).value;
    if (groupBy.isTimeDimension) return 'Sort by date';
    if (groupBy == GroupBy.category) return 'Sort by category name';
    if (groupBy == GroupBy.product) return 'Sort by product name';
    throw 'Unknown groupBy';
  }
}
