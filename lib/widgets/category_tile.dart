import '../source.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final firstLetter = category.name.substring(0, 1);
    final remaining = category.name.substring(1);
    final title =
        AppText(firstLetter.toUpperCase() + remaining, weight: FontWeight.w500);

    return AppMaterialButton(
        onPressed: () => push(CategoryEditPage(category: category)),
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        isFilled: false,
        child: ListTile(title: title));
  }
}
