import '../source.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Settings'), body: _buildBody());
  }

  _buildBody() {
    return ListView(
      children: [
        _buildListTile(Icons.inventory, 'Opening Stock', Pages.opening_stock),
        _buildListTile(Icons.qr_code, 'Products', Pages.products_page),
        _buildListTile(Icons.category, 'Products Categories',
            Pages.products_categories_page),
        _buildListTile(Icons.category, 'Expense Categories',
            Pages.expenses_categories_page),
      ],
    );
  }

  _buildListTile(IconData icon, String title, Pages nextPage) {
    return AppMaterialButton(
      onPressed: () => _navigateToOpeningStockPage(nextPage),
      isFilled: false,
      child: ListTile(
        title: Row(
          children: [
            Icon(icon, color: AppColors.onBackground, size: 22.dw),
            SizedBox(width: 15.dw),
            AppText(title, weight: FontWeight.w500),
          ],
        ),
        trailing: Icon(Icons.chevron_right, size: 22.dw),
        contentPadding: EdgeInsets.symmetric(horizontal: 19.dw),
      ),
    );
  }

  _navigateToOpeningStockPage(Pages page) {
    late final Widget nextPage;

    switch (page) {
      case Pages.opening_stock:
        nextPage = const OpeningStockItemsPage();
        break;
      case Pages.products_page:
        nextPage = const ProductsPage();
        break;
      case Pages.products_categories_page:
        nextPage = CategoriesPage(CategoryType.products());
        break;
      case Pages.expenses_categories_page:
        nextPage = CategoriesPage(CategoryType.expenses());
        break;
      default:
    }

    push(nextPage);
  }
}
