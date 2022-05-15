import 'package:inventory_management/blocs/query_filters_bloc.dart';
import 'package:inventory_management/source.dart';
import 'find_options.dart';

typedef SortDirFilter = QueryFilter<SortDirection>;
typedef GroupByFilter = QueryFilter<GroupBy>;
typedef CategoryFilter = QueryFilter<Category>;
typedef ProductFilter = QueryFilter<Product>;
typedef DateRangeFilter = QueryFilter<DateTimeRange>;

class QueryFilter<T> {
  const QueryFilter(this.fieldName, this.value);

  final String fieldName;
  final T value;
}
