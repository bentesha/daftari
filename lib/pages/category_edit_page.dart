import '../source.dart';

class CategoryEditPage extends StatefulWidget {
  const CategoryEditPage({Key? key}) : super(key: key);

  @override
  State<CategoryEditPage> createState() => _CategoryEditPageState();
}

class _CategoryEditPageState extends State<CategoryEditPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AppText('CATEGORY EDIT PAGE')));
  }
}
