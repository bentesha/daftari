import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/stocks/inventory_movement_bloc.dart';
import 'package:inventory_management/blocs/stocks/inventory_movement_state.dart';
import 'package:inventory_management/source.dart';

import '../models/inventory_movement.dart';

class InventoryMovementPage extends StatefulWidget {
  final Product? product;
  const InventoryMovementPage([this.product, Key? key]) : super(key: key);

  @override
  State<InventoryMovementPage> createState() => _InventoryMovementPageState();
}

class _InventoryMovementPageState extends State<InventoryMovementPage> {
  late InventoryMovementBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<InventoryMovementBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: BlocBuilder<InventoryMovementBloc, InventoryMovementState>(
              builder: (_, state) {
            return state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.hasError
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error!, textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            AppTextButton(
                                backgroundColor: AppColors.primary,
                                height: 50,
                                onPressed: bloc.getInventoryMovementByProduct,
                                text: 'Try Again')
                          ],
                        ),
                      )
                    : state.hasNoData
                        ? const Center(
                            child: Text("No movements for this item"))
                        : Column(
                            children: [
                              _buildTableHeader(),
                              const AppDivider.zeroMargin(color: Colors.black),
                              _buildTable(state.inventoryMovements),
                            ],
                          );
          }),
        )
      ],
    );
  }

  _buildHeader() {
    final product = context.watch<InventoryMovementBloc>().state.product;
    return Container(
        height: 50,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: .5, color: Colors.black54))),
        child: ListTile(
          title: product == null
              ? const Text("Tap to select product")
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
          trailing: const Icon(EvaIcons.search),
          onTap: () async {
            final product = await ItemsSearchPage.navigateTo<Product>(context,
                showAddIcon: false);
            if (product != null) bloc.addProduct(product);
          },
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
