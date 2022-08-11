export 'documents_pages/sales_documents_page.dart';
export 'categories_page.dart';
export 'category_page.dart';
export 'product_page.dart';
export 'sales_page.dart';
export 'purchases_page.dart';
export 'document_pages/document_sales_page.dart';
export 'document_pages/document_purchases_page.dart';
export 'products_page.dart';
export 'search_page.dart';
export 'dashboard/dashboard_page.dart';
export 'reports/report_page.dart';
export 'expense_page.dart';
export 'documents_pages/expenses_documents_page.dart';
export 'document_pages/document_write_offs_page.dart';
export 'write_off_page.dart';
export 'opening_stock_item_page.dart';
export 'opening_stock_items_page.dart';
export 'documents_pages/purchases_documents_page.dart';
export 'document_pages/document_expenses_page.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

T getService<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}
