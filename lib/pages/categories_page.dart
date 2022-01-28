import '../source.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(Pages.categories_page),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    final isScaffoldStateNull = _scaffoldKey.currentState == null;
    _openDrawer() {
      if (isScaffoldStateNull) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scaffoldKey.currentState!.openDrawer();
        });
      } else {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return AppTopBar(showDrawerCallback: _openDrawer, title: "Categories");
  }

  _buildBody() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DayTitle(),
        ListView.separated(
          separatorBuilder: (_, __) => Container(
            height: 1.5.dw,
            color: AppColors.divider,
          ),
          itemCount: _categoriesList.length,
          itemBuilder: (_, index) {
            final category = _categoriesList[index];
            return AppTextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ItemPage(category.title))),
                padding: EdgeInsets.symmetric(vertical: 5.dh),
                isFilled: false,
                child: category);
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        )
      ],
    );
  }

  final _categoriesList = const <CategoryTile>[
    CategoryTile(title: 'Drinks', numberOfItems: 4),
    CategoryTile(title: 'Toiletries', numberOfItems: 21),
    CategoryTile(title: 'Bags', numberOfItems: 10),
    CategoryTile(title: 'Foods', numberOfItems: 5),
  ];
}
