import 'dart:async';
import '../source.dart';

class RecordsService {
  static final _box = Hive.box(Constants.kRecordsBox);
  static final _recordList = <Record>[];

  List<Record> get getRecordList => _recordList;

  final _controller = StreamController<Record>.broadcast();
  Stream<Record> get getRecordStream => _controller.stream.distinct();

  List<Record> getAll() {
    if (_box.isEmpty) return [];

    for (Record record in _box.values) {
      final index = _recordList.indexWhere((e) => e.id == record.id);
      if (index == -1) _recordList.add(record);
    }

    return _recordList;
  }

  Future<void> addRecord(Record record) async {
    await _box.add(record);
    _recordList.add(record);
    _controller.add(record);
  }
}
