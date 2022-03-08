import '../source.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const Category._();

  const factory Category(
      {required String id,
      required String? description,
      required String type,
      required String name}) = _Category;

  factory Category.empty() =>
      const Category(id: '', description: '', name: '', type: '');

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => {'name': name, 'description': description};
}
