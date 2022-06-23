import 'package:inventory_management/source.dart';

enum SortDirection { ascending, descending }

extension SortDirectionExtension on SortDirection {
  String get queryName {
    if (this == SortDirection.ascending) return 'asc';
    return 'desc';
  }
}

enum GroupBy { day, month, quarter, year, category, product }

extension GroupByExtension on GroupBy {
  bool get isTimeDimension {
    return this == GroupBy.day ||
        this == GroupBy.month ||
        this == GroupBy.quarter ||
        this == GroupBy.year;
  }
}

typedef SortDirFilter = QueryFilter<SortDirection>;
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