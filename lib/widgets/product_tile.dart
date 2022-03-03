import '../source.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AppMaterialButton(
      onPressed: () => push(ProductEditPage(product: product)),
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      isFilled: false,
      child: ListTile(
        title: AppText(product.name),
        trailing: AppText(product.getUnitPrice, weight: FontWeight.bold),
      ),
    );
  }
}
