import '../source.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, required this.title, required this.numberOfItems})
      : super(key: key);

  final String title;
  final int numberOfItems;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: AppText(title, weight: FontWeight.w500),
        contentPadding: EdgeInsets.symmetric(horizontal: 18.dw),
        subtitle: AppText('$numberOfItems item${numberOfItems > 1 ? 's' : ''}',
            opacity: .75));
  }
}
