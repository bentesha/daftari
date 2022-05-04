class FindOptions<T> {
  T? _sortField;
  final filters = <T, dynamic>{};
  var _sortDirection = SortDirection.ascending;

  T? get sortField => _sortField;
  SortDirection get sortDirection => _sortDirection;

  void addFilter(T field, dynamic value) {
    filters[field] = value;
  }

  void sort(T field, SortDirection direction) {
    _sortField = field;
    _sortDirection = direction;
  }
}

enum SortDirection { ascending, descending }
