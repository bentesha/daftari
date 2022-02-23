import '../source.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, required this.category, required this.numberOfItems})
      : super(key: key);

  final Category category;
  final int numberOfItems;

  @override
  Widget build(BuildContext context) {
    final shouldUsePlural = numberOfItems > 1 || numberOfItems == 0;

    return AppMaterialButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => CategoryPage(category))),
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      isFilled: false,
      child: ListTile(
          title: AppText(category.name, weight: FontWeight.w500),
          subtitle: category.type == CategoryType.expenses().name
              ? Container()
              : AppText('$numberOfItems item${shouldUsePlural ? 's' : ''}',
                  opacity: .75)),
    );
  }
}
