export 'sales_documents_page.dart';
export 'categories_page.dart';
export 'category_page.dart';
export 'product_page.dart';
export 'sales_page.dart';
export 'purchases_page.dart';
export 'document_sales_page.dart';
export 'document_purchases_page.dart';
export 'products_page.dart';
export 'search_page.dart';
export 'dashboard.dart';
export 'reports_page.dart';
export 'expense_page.dart';
export 'expenses_documents_page.dart';
export 'document_write_offs_page.dart';
export 'write_off_page.dart';
export 'opening_stock_edit_page.dart';
export 'opening_stock_page.dart';
export 'purchases_documents_page.dart';
export 'document_expenses_page.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:provider/provider.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

T getService<T>(BuildContext context) {
  return Provider.of<T>(context, listen: false);
}
