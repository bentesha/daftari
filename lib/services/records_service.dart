import 'dart:async';
import '../source.dart';

class RecordsService {
  static final _box = Hive.box(Constants.kRecordsBox);
  static final _recordList = <Record>[];

  List<Record> get getRecordList => _recordList;

  final _controller = StreamController<Record>.broadcast();
  Stream<Record> get getRecordStream => _controller
          .stream /* .distinct((r1, r2) {
        log((r1 == r2).toString());
        return r1.id == r2.id;
      }) */
      ;

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

  Future<void> editRecord(Record record) async {
    _box.put(record.id, record);
    final index = _recordList.indexWhere((e) => e.id == record.id);
    log(index.toString());
    _recordList[index] = record;
    _controller.add(record);
  }

  ///returns a list of two amounts, first is total amount of income and second is
  ///the total amount of expenses in the specific day.
  double getTotalAmountsByDay(int day) {
    double sales = 0;
    final list = _recordList.where((e) => e.date.day == day).toList();
    if (list.isEmpty) return 0;

    for (Record record in list) {
      if (record.type == RecordsTypes.sales) sales += record.totalAmount;
    }
    return sales;
  }

  Map<int, double> getAllTotalAmounts() {
    final days = DateFormatter.getDaysInMonth();
    final amountsMap = <int, double>{};
    for (int day = 1; day <= days; day++) {
      final amountsList = getTotalAmountsByDay(day);
      amountsMap[day] = amountsList;
    }
    return amountsMap;
  }
}
