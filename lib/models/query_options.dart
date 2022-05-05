import 'package:flutter/material.dart';
import 'package:inventory_management/models/find_options.dart';
import 'category.dart';
import 'product.dart';

class QueryOptions {
  QueryOptions(String defaultGroupByOption,
      {this.sortDirection = SortDirection.descending})
      : groupBy = defaultGroupByOption;

  SortDirection sortDirection;
  String groupBy;

  final _filters = <QueryFilter>[];

  int get count => _filters.where((filter) => filter.hasValue).length;

  addFilter(QueryFilter filter) {
    if (filter.value == null) {
      removeFilter(filter.fieldName);
      return;
    }
    _filters.add(filter);
  }

  void removeFilter(String fieldName) {
    _filters.removeWhere((filter) => filter.fieldName == fieldName);
  }

  void clearAll<TFilter extends QueryFilter>() {
    _filters.removeWhere((filter) => filter is TFilter);
  }

  QueryFilter? operator [](String fieldName) {
    if (_filters.every((filter) => filter.fieldName != fieldName)) {
      return null;
    }
    final filter =
        _filters.firstWhere((filter) => filter.fieldName == fieldName);
    return filter;
  }

  QueryOptions copy() {
    final options = QueryOptions(groupBy);
    options.sortDirection = sortDirection;
    for (var filter in _filters) {
      options._filters.add(filter.copy());
    }
    return options;
  }
}

abstract class QueryFilter<T> {
  QueryFilter(this.fieldName);

  final String fieldName;
  T? value;

  bool get hasValue => value != null;

  QueryFilter<T> copy();
}

class DateRangeFilter extends QueryFilter<DateTimeRange> {
  DateRangeFilter(String fieldName) : super(fieldName);

  @override
  DateRangeFilter copy() => DateRangeFilter(fieldName)..value = value;
}

class BoolFilter extends QueryFilter<bool> {
  BoolFilter(String fieldName) : super(fieldName);

  @override
  BoolFilter copy() => BoolFilter(fieldName)..value = value;
}

class StringFilter extends QueryFilter<String> {
  StringFilter(String fieldName) : super(fieldName);

  @override
  StringFilter copy() => StringFilter(fieldName)..value = value;
}

class CategoryFilter extends QueryFilter<Category> {
  CategoryFilter(String fieldName) : super(fieldName);

  @override
  CategoryFilter copy() => CategoryFilter(fieldName)..value = value;
}

class ProductFilter extends QueryFilter<Product> {
  ProductFilter(String fieldName) : super(fieldName);

  @override
  ProductFilter copy() => ProductFilter(fieldName)..value = value;
}
