import 'package:flutter/material.dart';
import 'package:inventory_management/models/find_options.dart';
import 'package:inventory_management/widgets/reports/price_list.dart';

import 'category.dart';

class QueryOptions {
  QueryOptions(String defaultSortField,
      {this.sortDirection = SortDirection.ascending})
      : sortBy = defaultSortField;

  SortDirection sortDirection;
  String sortBy;

  final _filters = <QueryFilter>[];

  int get count => _filters.where((filter) => filter.hasValue).length;

  addFilter(QueryFilter filter) {
    _filters.add(filter);
  }

  bool removeFilter(QueryFilter filter) {
    return _filters.remove(filter);
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
    final options = QueryOptions(sortBy);
    options.sortDirection = sortDirection;
    for (var filter in _filters) {
      options._filters.add(filter.copy());
    }
    return options;
  }

  String getOrderByClause() {
    final sortDir = sortDirection == SortDirection.ascending ? 'ASC' : 'DESC';
    return '$sortBy $sortDir';
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