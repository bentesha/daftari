//did not use freezed because I needed custom toJson methods, and overriding
//toJson method is not supported yet. I had 2 options: create custom to and from
//json methods with different names like getFromJson and createToJson, because
//writing custom methods with these names (to- & from-Json) freezed detects that
//and creates the classes itself and it becomes controversial.
//Second option is to writing the boilerplate yourself.

import '../source.dart';

class Category {
  final String id, type, name;
  final String? description;

  const Category(
      {this.id = '', this.description, this.name = '', this.type = ''});

  Category.expenses({required this.id, this.description, required this.name})
      : type = 'Expenses';

  Category.products({required this.id, this.description, required this.name})
      : type = 'Products';

  Category copyWith(
      {String? id, String? type, String? name, String? description}) {
    return Category(
        id: id ?? this.id,
        description: description ?? this.description,
        name: name ?? this.name,
        type: type ?? this.type);
  }

  factory Category.fromJson(var json, [bool isExpenses = true]) {
    if (isExpenses) {
      return Category.expenses(
          id: json['id'], description: json['description'], name: json['name']);
    } else {
      return Category.products(
          id: json['id'], description: json['description'], name: json['name']);
    }
  }

  Map<String, String?> toJson() {
    String? _description;
    if (description != null) {
      //description can be '', that is empty and empty faces validation errors
      //from the server
      if (description!.isNotEmpty) _description = description!;
    }
    return {'name': name, 'description': _description};
  }
}
