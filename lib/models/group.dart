import '../source.dart';

part 'group.g.dart';

@HiveType(typeId: 2)
class Group {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String type;

  Group(
      {required this.id,
      required this.date,
      required this.title,
      this.type = GroupType.sales});

  factory Group.empty() => Group(id: '', date: DateTime.now(), title: '');

  Group copyWith({String? title, DateTime? date, String? type, String? id}) {
    return Group(
        id: id ?? this.id,
        date: date ?? this.date,
        title: title ?? this.title,
        type: type ?? this.type);
  }

  @override
  String toString() {
    return 'Group: $title';
  }
}

class GroupType {
  static const expenses = 'Expenses';
  static const sales = 'Sales';
}
