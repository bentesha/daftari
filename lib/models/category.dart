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

  @HiveField(3)
  final String? type;

  Category({required this.id, this.description, this.type, required this.name});

  factory Category.empty() => Category(id: '', description: '', name: '');

  Category copyWith(
      {String? name, String? description, String? id, String? type}) {
    return Category(
        id: id ?? this.id,
        description: description,
        name: name ?? this.name,
        type: type ?? this.type);
  }

  Map<String, String?> toJson() => {'name': name, 'description': description};

  factory Category.fromJson(var json) => Category(
      id: json['id']!,
      name: json['name']!,
      description: json['description'],
      type: CategoryType.products().name);
}
