import '../source.dart';

part 'category.g.dart';

@HiveType(typeId: 3)
class Category {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? description;

  Category({required this.id, required this.description, required this.name});

  factory Category.empty() => Category(id: '', description: '', name: '');

  Category copyWith({String? name, String? description, String? id}) {
    return Category(
        id: id ?? this.id, description: description, name: name ?? this.name);
  }
}
