import 'dart:async';
import '../source.dart';

class RecordsService extends ChangeNotifier {
  static final _box = Hive.box(Constants.kRecordsBox);
  static final _recordList = <Record>[];
  static final _groupsAmounts = <String, double>{};

  List<Record> get getRecordList => _recordList;
  Map<String, double> get getGroupsTotalAmounts => _groupsAmounts;

  List<Record> getAll() {
    if (_box.isEmpty) return [];

    for (Record record in _box.values) {
      final index = _recordList.indexWhere((e) => e.id == record.id);
      if (index == -1) _recordList.add(record);
    }

    return _recordList;
  }

  ///Gets all the records from Hive, and calculates the total records amount in
  ///each sales group
  void init() {
    getAll();
    getGroupsRecordsTotals();
  }

  Future<void> addRecord(Record record) async {
    await _box.add(record);
    _recordList.add(record);

    final groupIdAmount = _groupsAmounts[record.groupId] ?? 0;
    _groupsAmounts[record.groupId] = groupIdAmount + record.totalAmount;
    notifyListeners();
  }

  Future<void> editRecord(Record record) async {
    _box.put(record.id, record);
    final index = _recordList.indexWhere((e) => e.id == record.id);
    final beforeEditRecordAmount = _recordList[index].totalAmount;
    _recordList[index] = record;

    final beforeEditGroupAmount = _groupsAmounts[record.groupId]!;
    _groupsAmounts[record.groupId] =
        beforeEditGroupAmount - beforeEditRecordAmount + record.totalAmount;
    notifyListeners();
  }

  Map<String, double> getGroupsRecordsTotals() {
    final groupsIds = _getGroupsIds();
    for (String id in groupsIds) {
      _groupsAmounts[id] = _getTotalRecordsAmount(id);
    }
    return _groupsAmounts;
  }

  List<String> _getGroupsIds() {
    final idList = <String>[];
    for (Record record in _recordList) {
      if (idList.contains(record.groupId)) continue;
      idList.add(record.groupId);
    }
    return idList;
  }

  double _getTotalRecordsAmount(String id) {
    double sales = 0;
    final list = _recordList.where((e) => e.groupId == id).toList();
    if (list.isEmpty) return 0;

    for (Record record in list) {
      if (record.type == RecordsTypes.sales) sales += record.totalAmount;
    }
    return sales;
  }
}
