class CategoryType {
  final String name;
  CategoryType._(this.name);

  factory CategoryType.expenses() => CategoryType._('Expenses');
  factory CategoryType.products() => CategoryType._('Products');
}
