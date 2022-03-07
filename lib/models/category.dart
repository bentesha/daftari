import '../source.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category(
      {required String id,
      required String? description,
      required String type,
      required String name}) = _Category;

  factory Category.empty() =>
      const Category(id: '', description: '', name: '', type: '');

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      name: json['name']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'description': description};
}
