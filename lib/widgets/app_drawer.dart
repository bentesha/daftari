import '../source.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(this.currentPage, {Key? key}) : super(key: key);

  final Pages currentPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330.dw,
      child: Drawer(
        backgroundColor: AppColors.secondary,
        child: Padding(
          padding: EdgeInsets.only(right: 19.dw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildOtherPagesList(),
              _buildSettingsButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTitle() {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(left: 19.dw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.dh),
            const AppText(
              'Mary James',
              color: AppColors.onSecondary,
              weight: FontWeight.w500,
            ),
            SizedBox(height: 5.dh),
            AppText(
              '@ Bella Bella Boutique',
              color: AppColors.onSecondary,
              opacity: .75,
              size: 14.dw,
            ),
          ],
        ),
      );
    });
  }

  _buildOtherPagesList() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildListTile('Categories', Pages.categories_page),
          _buildListTile('Sales', Pages.sales_page),
          _buildListTile('Purchases', Pages.purchases_page),
          _buildListTile('Expenses', Pages.expenses_page),
          _buildListTile('Stock Adjustment', Pages.stock_adjustment_page),
        ],
      ),
    );
  }

  _buildListTile(String title, Pages page) {
    final isCurrent = page == currentPage;
    return Builder(builder: (context) {
      return ListTile(
        title: AppTextButton(
          onPressed: () => _navigateTo(page, context),
          isFilled: false,
          alignment: Alignment.centerLeft,
          height: 40.dh,
          padding: EdgeInsets.only(left: 19.dw),
          child: AppText(
            title,
            weight: FontWeight.w500,
            color: isCurrent
                ? AppColors.accent
                : AppColors.onSecondary.withOpacity(.75),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        dense: true,
      );
    });
  }

  _navigateTo(Pages page, BuildContext context) {
    if (page == currentPage) return;
    Widget nextPage = const CategoriesPage();

    switch (page) {
      case Pages.sales_page:
        nextPage = const SalesRecordsPage();
        break;
      case Pages.categories_page:
        nextPage = const CategoriesPage();
        break;
      case Pages.purchases_page:
        nextPage = const PurchasesPage();
        break;
      case Pages.expenses_page:
        nextPage = const ExpensesPage();
        break;
      case Pages.stock_adjustment_page:
        nextPage = const StockManagement();
        break;
      default:
    }
    //closes the drawer in the page from which it naviagates to the other page.
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage));
  }

  _buildSettingsButton() {
    return AppTextButton(
      onPressed: () {},
      text: 'Settings',
      height: 40.dh,
      isFilled: false,
      margin: EdgeInsets.only(bottom: 20.dh),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 19.dw),
    );
  }
}
