// ignore_for_file: constant_identifier_names

import 'package:inventory_management/pages/landing_pages/expenses_landing_page.dart';
import 'package:inventory_management/pages/settings_page.dart';
import 'package:inventory_management/pages/documents_pages/write_offs_documents_page.dart';
import '../pages/landing_pages/purchases_landing_page.dart';
import '../pages/reports/reports_page.dart';
import '../pages/landing_pages/sales_landing_page.dart';
import '../source.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  static final pageNotifier = ValueNotifier<Pages>(Pages.dashboard);

  @override
  void initState() {
    pageNotifier.value = Pages.dashboard;
    super.initState();
  }

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
          _buildListTile('Sales', Pages.sales_documents_page),
          _buildListTile('Purchases', Pages.purchases_documents_page),
          _buildListTile('Expenses', Pages.expenses_documents_page),
          _buildListTile('Stock Write-offs', Pages.stock_write_offs_page),
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
    return _buildListTile('Settings', Pages.settings_page);
  }

  _navigateTo(Pages page, BuildContext context) {
    late Widget? nextPage;

    pageNotifier.value = page;

    switch (page) {
      case Pages.dashboard:
        Navigator.pop(context);
        Navigator.popUntil(context, ((route) => route.isFirst));
        return;
      case Pages.sales_documents_page:
        nextPage = const SalesLandingPage();
        break;
      case Pages.purchases_documents_page:
        nextPage = const PurchasesLandingPage();
        break;
      case Pages.reports_page:
        nextPage = const ReportsSelectorPage();
        break;
      case Pages.expenses_documents_page:
        nextPage = const ExpensesLandingPage();
        break;
      case Pages.stock_write_offs_page:
        nextPage = const WriteOffsDocumentsPages();
        break;
      case Pages.settings_page:
        nextPage = const SettingsPage();
        break;
      default:
        nextPage = null;
    }

    if (nextPage == null) return;
    push(nextPage);
  }
}

enum Pages {
  dashboard,
  sales_documents_page,
  sales_page,
  document_sales_page,
  expenses_documents_page,
  document_expenses_page,
  expense_page,
  write_off_page,
  document_write_offs_page,
  write_offs_documents_page,
  reports_page,
  categories_page,
  category_page,
  purchases_page,
  products_categories_page,
  expenses_categories_page,
  stock_write_offs_page,
  products_page,
  document_purchases_page,
  purchases_documents_page,
  product_page,
  opening_stock_item_page,
  opening_stock_items_page,
  settings_page,
  opening_stock
}
