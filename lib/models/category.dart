//did not use freezed because I needed custom toJson methods, and overriding
//toJson method is not supported yet. I had 2 options: create custom to and from
//json methods with different names like getFromJson and createToJson, because
//writing custom methods with these names (to- & from-Json) freezed detects that
//and creates the classes itself and it becomes controversial.
//Second option is to writing the boilerplate yourself.

class Category {
  final String id, type, name;
  final String? description;

  const Category(
      {required this.id,
      required this.description,
      required this.type,
      required this.name});

  factory Category.empty() =>
      const Category(id: '', description: '', name: '', type: '');

  Category copyWith(
      {String? id, String? type, String? name, String? description}) {
    return Category(
        id: id ?? this.id,
        description: description ?? this.description,
        name: name ?? this.name,
        type: type ?? this.type);
  }

  factory Category.fromJson(Map<String, dynamic> json, String type) => Category(
      id: json['id'],
      description: json['description'],
      type: type,
      name: json['name']);

  Map<String, String?> toJson() => {'name': name, 'description': description};
}
