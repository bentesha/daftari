import 'package:inventory_management/pages/settings_page.dart';
import '../source.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  static final pageNotifier = ValueNotifier<Pages>(Pages.dashboard);

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
          _buildListTile('Dashboard', Pages.dashboard),
          _buildListTile('Sales', Pages.sales_page),
          _buildListTile('Expenses', Pages.expenses_page),
          _buildListTile('Purchases', Pages.purchases_page),
          _buildListTile('Stock Adjustment', Pages.stock_adjustment_page),
          _buildListTile('Items', Pages.items_page),
          _buildListTile('Categories', Pages.categories_page),
          _buildListTile('Reports', Pages.reports_page),
        ],
      ),
    );
  }

  _buildListTile(String title, Pages page) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, currentPage, child) {
          final isCurrent = page == currentPage;

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

  _buildSettingsButton() {
    return Builder(builder: (context) {
      return AppTextButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SettingsPage())),
        text: 'Settings',
        height: 40.dh,
        isFilled: false,
        margin: EdgeInsets.only(bottom: 20.dh),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 19.dw),
      );
    });
  }

  _navigateTo(Pages page, BuildContext context) {
    late Widget? nextPage;

    pageNotifier.value = page;

    switch (page) {
      case Pages.dashboard:
        Navigator.pop(context);
        Navigator.popUntil(context, ((route) => route.isFirst));
        return;
      case Pages.sales_page:
        nextPage = const SalesRecordsPage();
        break;
      case Pages.categories_page:
        nextPage = const CategoriesPage();
        break;
      case Pages.items_page:
        nextPage = const ItemsPage();
        break;
      case Pages.reports_page:
        nextPage = const ReportsPage();
        break;
      case Pages.expenses_page:
        nextPage = const ExpensesPage();
        break;
      default:
        nextPage = null;
    }
    if (nextPage == null) return;

    Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage!));
  }
}
