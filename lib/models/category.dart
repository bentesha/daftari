import '../source.dart';

part 'category.freezed.dart';
part 'category.g.dart';

//TODO can't add a new category with an error related to json.

@freezed
class Category with _$Category {
  const Category._();

  const factory Category(
      {required String id,
     @JsonKey(includeIfNull: true) required String? description,
      required String type,
      required String name}) = _Category;

  factory Category.empty() =>
      const Category(id: '', description: '', name: '', type: '');

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, String?> createJson() => {'name': name, 'description': description};
}
