import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/models/option_item.dart';
import 'package:inventory_management/blocs/filter/query_options.dart';
import 'package:inventory_management/source.dart';
import 'package:inventory_management/widgets/choice_chip.dart';
import 'package:inventory_management/widgets/date_range_picker_form_cell.dart';
import 'package:inventory_management/widgets/form_cell_divider.dart';
import 'package:inventory_management/widgets/form_cell_item_picker.dart';

class SalesFilterDialog extends StatefulWidget {
  final ReportType reportType;
  const SalesFilterDialog(this.reportType, {Key? key}) : super(key: key);

  ///returns true if the filters were edited.
  static Future<bool?> navigateTo(BuildContext context, ReportType type) {
    return Navigator.of(context).push(
        MaterialPageRoute<bool>(builder: (context) => SalesFilterDialog(type)));
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
      final groupByFilter =
          (context.watch<QueryFiltersBloc>()['groupBy'] as GroupByFilter?);
      final hasGroupBy = groupByFilter != null;
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
                        color: AppColors.onPrimary, size: 16.dw)),
                const SizedBox(width: 10)
              ]),
          body: ListView(
            children: [
              if (widget.reportType != ReportType.remainingStock)
                ChoiceChipFormCell<GroupBy?>(
                    label: 'GROUP BY',
                    value: (options['groupBy'] as GroupByFilter?)?.value,
                    options: [
                      const OptionItem(value: GroupBy.day, label: 'Day'),
                      const OptionItem(value: GroupBy.month, label: 'Month'),
                      const OptionItem(
                          value: GroupBy.quarter, label: 'Quarter'),
                      const OptionItem(value: GroupBy.year, label: 'Year'),
                      if (widget.reportType != ReportType.expenses)
                        const OptionItem(
                            value: GroupBy.product, label: 'Product'),
                      const OptionItem(
                          value: GroupBy.category, label: 'Category'),
                    ],
                    onSelected: (value) =>
                        options.addFilter<GroupBy>('groupBy', value)),
              if (widget.reportType == ReportType.inventoryMovement &&
                  hasGroupBy)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextButton(
                        onPressed: () => options.removeFilter('groupBy'),
                        child: const Text('Remove groupBy Filter')),
                  ),
                ),
              const FormCellDivider(subDivider: true),
              if (widget.reportType == ReportType.remainingStock && hasGroupBy)
                ChoiceChipFormCell<SortBy>(
                    label: 'SORT BY',
                    value: (options['sortBy'] as SortByFilter).value,
                    options: const [
                      OptionItem(label: 'Product', value: SortBy.product),
                      OptionItem(label: "Category", value: SortBy.category)
                    ],
                    onSelected: (value) =>
                        options.addFilter<SortBy>('sortBy', value)),
              if (widget.reportType != ReportType.remainingStock && hasGroupBy)
                ChoiceChipFormCell<SortBy>(
                    label: 'SORT BY',
                    value: (options['sortBy'] as SortByFilter).value,
                    options: [
                      OptionItem(
                          label: _getDimension(), value: SortBy.dimension),
                      OptionItem(label: getMetric(), value: SortBy.metric)
                    ],
                    onSelected: (value) =>
                        options.addFilter<SortBy>('sortBy', value)),
              const FormCellDivider(subDivider: true),
              if (hasGroupBy)
                ChoiceChipFormCell<SortDirection>(
                    label: 'SORT DIRECTION',
                    value: (options['sortDirection'] as SortDirFilter).value,
                    options: const [
                      OptionItem(
                          label: 'Ascending', value: SortDirection.ascending),
                      OptionItem(
                          label: 'Descending', value: SortDirection.descending)
                    ],
                    onSelected: (value) => options.addFilter<SortDirection>(
                        'sortDirection', value)),
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
              if (widget.reportType != ReportType.expenses)
                FormCellItemPicker(
                    label: 'PRODUCT',
                    valueText:
                        (options['product'] as ProductFilter?)?.value.name,
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

  String _getDimension() {
    final filtersBloc = BlocProvider.of<QueryFiltersBloc>(context);
    final groupBy = (filtersBloc['groupBy'] as GroupByFilter).value;
    switch (groupBy) {
      case GroupBy.category:
        return 'Category';
      case GroupBy.product:
        return 'Product';
      case GroupBy.day:
      case GroupBy.month:
      case GroupBy.quarter:
      case GroupBy.year:
        return 'Date';
    }
  }

  String getMetric() {
    return widget.reportType.isInventoryMovement ? "Total" : "Revenue";
  }
}
