import 'package:inventory_management/source.dart';

enum SortDirection { ascending, descending }

extension SortDirectionExtension on SortDirection {
  String get queryName {
    if (this == SortDirection.ascending) return 'asc';
    return 'desc';
  }
}

/// [SortBy.dimension] and [SortBy.metric] are used to sort sales, expenses and purchases
/// reports. [SortBy.product] and [SortBy.category] are ony used to sort stocks.
enum SortBy { dimension, metric, product, category }

enum GroupBy {
  day,
  month,
  quarter,
  year,
  category,
  product,

  /// currently for write-offs only
  type
}

extension GroupByExtension on GroupBy {
  bool get isTimeDimension {
    return this == GroupBy.day ||
        this == GroupBy.month ||
        this == GroupBy.quarter ||
        this == GroupBy.year;
  }
}

typedef SortDirFilter = QueryFilter<SortDirection>;
typedef SortByFilter = QueryFilter<SortBy>;
typedef GroupByFilter = QueryFilter<GroupBy>;
typedef CategoryFilter = QueryFilter<Category>;
typedef ProductFilter = QueryFilter<Product>;
typedef DateRangeFilter = QueryFilter<DateTimeRange>;

class QueryFilter<T> {
  const QueryFilter(this.fieldName, this.value);

  final String fieldName;
  final T value;

  String get inURLQueryFormat {
    switch (T) {
      case SortDirection:
        final sortDirection = (value as SortDirection).queryName;
        return 'sortDir=$sortDirection';
      case SortBy:
        final sortBy = (value as SortBy).name;
        return 'sortBy=$sortBy';
      case GroupBy:
        final groupBy = (value as GroupBy).name;
        return 'groupBy=$groupBy';
      case Category:
        final categoryID = (value as Category).id;
        return 'categoryId=$categoryID';
      case Product:
        final productID = (value as Product).id;
        return 'productId=$productID';
      case DateTimeRange:
        final range = value as DateTimeRange;
        final start = FormatUtils.getFormattedDate(range.start);
        final end = FormatUtils.getFormattedDate(range.end);
        return 'startDate=$start&endDate=$end';
      default:
        return '';
    }
  }
}
