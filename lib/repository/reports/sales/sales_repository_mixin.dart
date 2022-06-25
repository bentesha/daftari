import 'package:intl/intl.dart';
import 'package:inventory_management/source.dart';

import '../../../blocs/filter/query_options.dart';
import '../../../blocs/report/models/annotation.dart';

class SalesRepositoryMixin {
  List<String> getItems(GroupBy groupBy, List<Map<String, dynamic>> data) {
    if (groupBy == GroupBy.product) {
      return data.map((e) => (e['Product.name']) as String).toList();
    }
    if (groupBy == GroupBy.category) {
      return data.map((e) => (e['Category.name']) as String).toList();
    }
    if (groupBy == GroupBy.day) {
      return data.map((e) {
        final date = e['SalesDocument.date.day'] as String;
        return FormatUtils.formatWithCustomFormatter(
            date, DateFormat('yyyy-MM-dd'));
      }).toList();
    }
    if (groupBy == GroupBy.month) {
      return data.map((e) {
        final date = e['SalesDocument.date.month'] as String;
        return FormatUtils.formatWithCustomFormatter(
            date, DateFormat('MMMM, yyyy'));
      }).toList();
    }
    if (groupBy == GroupBy.quarter) {
      return data.map((e) {
        final date = e['SalesDocument.date.quarter'] as String;
        return FormatUtils.formatToQuarters(date);
      }).toList();
    }
    if (groupBy == GroupBy.year) {
      return data.map((e) {
        final date = e['SalesDocument.date.year'] as String;
        return FormatUtils.formatWithCustomFormatter(date, DateFormat('yyyy'));
      }).toList();
    }
    return [];
  }

  Annotation getDimension(GroupBy groupBy, Map<String, dynamic> dimensionMap) {
    late final String dimensionKey;
    switch (groupBy) {
      case GroupBy.category:
        dimensionKey = 'Category.name';
        break;
      case GroupBy.product:
        dimensionKey = 'Product.name';
        break;
      case GroupBy.day:
        dimensionKey = 'SalesDocument.date.day';
        break;
      case GroupBy.month:
        dimensionKey = 'SalesDocument.date.month';
        break;
      case GroupBy.quarter:
        dimensionKey = 'SalesDocument.date.quarter';
        break;
      case GroupBy.year:
        dimensionKey = 'SalesDocument.date.year';
        break;
      default:
        throw 'Unknown groupBy';
    }

    return Annotation.fromMap(dimensionMap[dimensionKey]);
  }
}
