import 'dart:async';
import '../source.dart';

class RecordsService extends ChangeNotifier {
  static final _box = Hive.box(Constants.kRecordsBox);
  static final _recordList = <Record>[];

  List<Record> get getRecordList => _recordList;

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
    notifyListeners();
  }

  Future<void> editRecord(Record record) async {
    _box.put(record.id, record);
    final index = _recordList.indexWhere((e) => e.id == record.id);
    _recordList[index] = record;
    notifyListeners();
  }

  double _getTotalRecordsAmount([String? id, int? day]) {
    double sales = 0;
    final list = _recordList.where((e) {
      return id != null ? e.groupId == id : e.date.day == day;
    }).toList();
    if (list.isEmpty) return 0;

    for (Record record in list) {
      if (record.type == RecordsTypes.sales) sales += record.totalAmount;
    }
    return sales;
  }

  double getRecordsTotalByGroup(String id) => _getTotalRecordsAmount(id);

  double getRecordsTotalByDay(int day) => _getTotalRecordsAmount(null, day);

  Map<int, double> getAllRecordsTotal() {
    final days = DateFormatter.getDaysInMonth();
    final amountsMap = <int, double>{};
    for (int day = 1; day <= days; day++) {
      final amountsList = getRecordsTotalByDay(day);
      amountsMap[day] = amountsList;
    }
    return amountsMap;
  }

/*   List<int> get getDaysWithRecords {
    final days = <int>[];
    for (Record record in _recordList) {
      final day = record.date.day;
      if (days.contains(day)) continue;
      days.add(day);
    }
    return days;
  } */
}
