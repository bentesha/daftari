import 'package:bloc/bloc.dart';
import 'package:inventory_management/models/find_options.dart';
import '../models/query_options.dart';

enum GroupBy { day, month, quarter, year, item, category }

class QueryFilters extends Cubit<List<QueryFilter>> {
  static const initialState = [
    QueryFilter<GroupBy>('groupBy', GroupBy.category),
    QueryFilter<SortDirection>('sortDirection', SortDirection.descending)
  ];
  QueryFilters() : super(initialState);

  //state operations

  addFilter<T>(String fieldName, T? value) {
    final filters = List<QueryFilter>.from(state);
    //checking if field exists
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

  //getting values

  QueryFilter? operator [](String fieldName) {
    if (state.every((filter) => filter.fieldName != fieldName)) {
      return null;
    }
    final filter = state.firstWhere((filter) => filter.fieldName == fieldName);
    return filter;
  }
}
