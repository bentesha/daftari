import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../utils/extensions.dart/report_type.dart';
import 'query_options.dart';

class QueryFiltersBloc extends Cubit<List<QueryFilter>> {
  QueryFiltersBloc() : super(initialState);

  /// here to keep the bloc updated of the current [ReportType], so that it does not have
  /// to refresh the filters if the report type has not been changed;
  var _reportType = ReportType.sales;

  // cubit operations
  /// called when the [ReportType] is changed to reconfigure default states.
  refresh(ReportType type) {
    log('passed type: $type');
    if (_reportType == type) return;
    _reportType = type;
    if (type.isExpenses) {
      emit(defaultExpensesState);
    } else if (type.isRemainingStock) {
      emit(defaultStocksState);
    } else if (type.isInventoryMovement) {
      emit(defaultInventoryMvtState);
    } else {
      emit(initialState);
    }
  }

  addFilter<T>(String fieldName, T? value) {
    final filters = List<QueryFilter>.from(state);
    // checking if field exists
    final index = filters.indexWhere((filter) => filter.fieldName == fieldName);
    if (value == null) {
      if (index != -1) filters.removeAt(index);
    } else {
      final filter = QueryFilter<T>(fieldName, value);
      if (index == -1) filters.add(filter);
      if (index != -1) filters[index] = filter;
    }
    emit(filters);
  }

  void removeFilter(String fieldName) {
    final filters = List<QueryFilter>.from(state);
    filters.removeWhere((filter) => filter.fieldName == fieldName);
    emit(filters);
  }

  void clearAll() => emit(initialState);

  // getting values from state
  /// Gets a specific [QueryFilter] from a list of filters available. It returns null if
  /// [fieldName] did not match a field name of any available filters.
  QueryFilter? operator [](String fieldName) {
    if (state.every((filter) => filter.fieldName != fieldName)) {
      return null;
    }
    final filter = state.firstWhere((filter) => filter.fieldName == fieldName);
    return filter;
  }

  /// Converts a list of filters to a query that can be used while sending requests to the
  /// server.
  String getQuery() {
    var query = '';
    for (var i = 0; i < state.length; i++) {
      final filter = state[i];
      query = query + filter.inURLQueryFormat;
      if (i != state.length - 1) query = query + '&';
    }
    return query;
  }

  static const initialState = [
    QueryFilter<GroupBy>('groupBy', GroupBy.product),
    QueryFilter<SortDirection>('sortDirection', SortDirection.descending),
    QueryFilter<SortBy>('sortBy', SortBy.dimension)
  ];
  static const defaultExpensesState = [
    QueryFilter<GroupBy>('groupBy', GroupBy.category),
    QueryFilter<SortDirection>('sortDirection', SortDirection.descending),
    QueryFilter<SortBy>('sortBy', SortBy.dimension)
  ];
  static const defaultStocksState = [
    QueryFilter<SortDirection>('sortDirection', SortDirection.descending),
    QueryFilter<SortBy>('sortBy', SortBy.product)
  ];
  static const defaultInventoryMvtState = [
    QueryFilter<SortDirection>('sortDirection', SortDirection.descending),
    QueryFilter<SortBy>('sortBy', SortBy.metric)
  ];
}
