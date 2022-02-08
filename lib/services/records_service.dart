import '../source.dart';

class RecordsService {
  static final _box = Hive.box(Constants.kRecordsBox);
  static final _recordsList = <Record>[];

  List<Record> getAll() {
    if (_box.isEmpty) return [];

    for (Record record in _box.values) {
      final index = _recordsList.indexWhere((e) => e.id == record.id);
      if (index == -1) _recordsList.add(record);
    }

    return _recordsList;
  }
}
