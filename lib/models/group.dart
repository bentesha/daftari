import '../source.dart';

part 'group.g.dart';

@HiveType(typeId: 2)
class Group {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final DateTime date;

  Group({required this.id, required this.date, required this.title});

  factory Group.empty() => Group(id: '', date: DateTime.now(), title: '');

  Group copyWith({String? title}) =>
      Group(id: id, date: date, title: title ?? this.title);

  String get getTitleFromDate {
    final ordinal = DateFormatter.getOrdinalsFrom(date.day);
    final weekDay = DateFormatter.getWeekDay(date.weekday);
    return '${date.day}$ordinal, $weekDay';
  }
}
