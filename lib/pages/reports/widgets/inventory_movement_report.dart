import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';
import 'package:inventory_management/source.dart';

import '../../../blocs/filter/query_options.dart';
import '../../../blocs/report/models/report_data.dart';
import '../../../models/inventory_movement.dart';
import 'report.dart';

class InventoryMovementReport extends StatefulWidget {
  final List<InventoryMovement>? inventoryMovements;
  final ReportData? reportData;
  final VoidCallback onTappedToSelect;
  const InventoryMovementReport(this.inventoryMovements, this.reportData,
      {required this.onTappedToSelect, Key? key})
      : super(key: key);

  @override
  State<InventoryMovementReport> createState() => _InventoryMovementPageState();
}

class _InventoryMovementPageState extends State<InventoryMovementReport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        if (widget.inventoryMovements != null)
          Expanded(
              child: widget.inventoryMovements!.isEmpty
                  ? const Center(child: Text("No Data"))
                  : Column(
                      children: [
                        _buildTableHeader(),
                        const AppDivider.zeroMargin(color: Colors.black),
                        _buildTable(widget.inventoryMovements!)
                      ],
                    )),
        if (widget.reportData != null)
          Expanded(
              child: widget.reportData!.items.isEmpty
                  ? const Center(child: Text("No Data"))
                  : Report(data: widget.reportData!))
      ],
    );
  }

  _buildHeader() {
    final product =
        (context.watch<QueryFiltersBloc>()['product'] as ProductFilter?)?.value;
    return Container(
        height: 50,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: .5, color: Colors.black54))),
        child: ListTile(
          title: product == null
              ? const Text("Tap to select product.")
              : RichText(
                  text: TextSpan(
                      text: 'Product: ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: kFontFam),
                      children: [
                      TextSpan(
                          text: product.name,
                          style: const TextStyle(fontWeight: FontWeight.normal))
                    ])),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          onTap: product == null ? widget.onTappedToSelect : null,
        ));
  }

  _buildTableHeader() {
    return Container(
      color: AppColors.surface,
      height: 50,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          _buildTableHeaderValue('Movement Type', TextAlign.left),
          _buildTableHeaderValue("Quantity"),
          _buildTableHeaderValue("Total", TextAlign.right)
        ],
      ),
    );
  }

  _buildTable(List<InventoryMovement> inventoryMovements) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (_, index) {
              final movement = inventoryMovements[index];
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      _buildTableValue(movement.type, TextAlign.left),
                      _buildTableValue('${movement.product.stockQuantity}'),
                      _buildTableValue(
                          '${movement.product.stockValue}', TextAlign.right),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const AppDivider(),
            itemCount: inventoryMovements.length));
  }

  _buildTableHeaderValue(String title, [TextAlign? alignment]) {
    return Expanded(
        child: Text(title,
            textAlign: alignment ?? TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold)));
  }

  _buildTableValue(String value, [TextAlign? alignment]) {
    return Expanded(
        child: Text(value, textAlign: alignment ?? TextAlign.center));
  }
}
