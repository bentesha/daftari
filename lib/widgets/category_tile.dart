import '../source.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final title = AppText(category.name, weight: FontWeight.w500);

    return AppMaterialButton(
        onPressed: () => push(CategoryEditPage(category: category)),
        padding: EdgeInsets.symmetric(horizontal: 19.dw),
        isFilled: false,
        child: ListTile(title: title));
  }
}
