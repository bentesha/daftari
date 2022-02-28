// ignore_for_file: constant_identifier_names

import 'package:inventory_management/pages/settings_page.dart';
import 'package:inventory_management/pages/write_off_groups_page.dart';
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
          _buildListTile('Expenses', Pages.group_expenses_page),
          _buildListTile('Purchases', Pages.purchases_page),
          _buildListTile('Products', Pages.products_page),
          _buildListTile('Products Categories', Pages.products_categories_page),
          _buildListTile('Expenses Categories', Pages.expenses_categories_page),
          _buildListTile('Stock Writeoffs', Pages.stock_write_offs_page),
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
      case Pages.expenses_categories_page:
        nextPage = CategoriesPage(CategoryType.expenses());
        break;
      case Pages.products_categories_page:
        nextPage = CategoriesPage(CategoryType.products());
        break;
      case Pages.products_page:
        nextPage = const ItemsPage();
        break;
      case Pages.reports_page:
        nextPage = const ReportsPage();
        break;
      case Pages.group_expenses_page:
        nextPage = const ExpensesGroupsPage();
        break;
      case Pages.stock_write_offs_page:
        nextPage = const WriteOffGroupsPage();
        break;
      default:
        nextPage = null;
    }
    if (nextPage == null) return;

    Navigator.push(context, MaterialPageRoute(builder: (_) => nextPage!));
  }
}

enum Pages {
  sales_page,
  dashboard,
  reports_page,
  products_categories_page,
  expenses_categories_page,
  purchases_page,
  expenses_groups_page,
  group_expenses_page,
  expense_edit_page,
  write_off_groups_page,
  group_write_offs_page,
  write_offs_edit_page,
  stock_write_offs_page,
  products_page
}
