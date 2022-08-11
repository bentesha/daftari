import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:inventory_management/blocs/filter/query_filters_bloc.dart';

import '../../../source.dart';

class InventoryMovementCard extends StatelessWidget {
  final List<Product> products;
  const InventoryMovementCard(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.dw),
      padding: EdgeInsets.fromLTRB(10.dw, 10.dh, 10.dw, 15.dh),
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.all(Radius.circular(10.dw))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText("Inventory Movement", size: 15.dw, weight: FontWeight.bold),
          AppText('By Product', size: 14.dw, color: AppColors.onBackground2),
          AppDivider(margin: EdgeInsets.only(top: 5.dh, bottom: 10.dh)),
          if (products.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(child: Text('No data')),
            ),
          if (products.isNotEmpty)
            Column(
              children: List.generate(
                  products.length,
                  (index) => ListTile(
                        title: Text(products[index].name),
                        onTap: () {
                          context
                              .read<QueryFiltersBloc>()
                              .addFilter<Product>('product', products[index]);
                          push(const ReportPage(
                              reportType: ReportType.inventoryMovement));
                        },
                        trailing: const Icon(EvaIcons.arrowForwardOutline),
                      )),
            ),
          AppDivider.withVerticalMargin(5.dh),
          AppTextButton(
              onPressed: () {
                push(const ReportPage(
                    reportType: ReportType.inventoryMovement));
              },
              text: 'View All',
              height: 40.dh,
              isFilled: false,
              borderRadius: BorderRadius.all(Radius.circular(15.dw)),
              textStyle: TextStyle(color: AppColors.primary, fontSize: 15.dw))
        ],
      ),
    );
  }
}
