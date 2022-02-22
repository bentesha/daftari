import 'dart:async';
import '../source.dart';
import 'service.dart';

class RecordsService extends Service<Record> {
  static final _box = Hive.box(Constants.kRecordsBox);
  RecordsService() : super(_box);

  final _groupsAmounts = <String, double>{};
  Map<String, double> get getGroupsTotalAmounts => _groupsAmounts;

  void init() {
    super.getAll();
    _getGroupsRecordsTotals();
  }

  @override
  Future<void> add(var item) async {
    await _box.put(item.id, item);

    final groupIdAmount = _groupsAmounts[item.groupId] ?? 0;
    _groupsAmounts[item.groupId] = groupIdAmount + item.totalAmount;
    super.refresh();
    notifyListeners();
  }

  @override
  Future<void> edit(var item) async {
    await _box.put(item.id, item);

    final index = super.getList.indexWhere((e) => e.id == item.id);
    final beforeEditRecordAmount = super.getList[index].totalAmount;

    final beforeEditGroupAmount = _groupsAmounts[item.groupId]!;
    _groupsAmounts[item.groupId] =
        beforeEditGroupAmount - beforeEditRecordAmount + item.totalAmount;

    super.refresh();
    notifyListeners();
  }

  Map<String, double> _getGroupsRecordsTotals() {
    final groupsIds = _getGroupsIds();
    for (String id in groupsIds) {
      _groupsAmounts[id] = _getTotalRecordsAmount(id);
    }
    return _groupsAmounts;
  }

  List<String> _getGroupsIds() {
    final idList = <String>[];
    for (Record record in super.getList) {
      if (idList.contains(record.groupId)) continue;
      idList.add(record.groupId);
    }
    return idList;
  }

  double _getTotalRecordsAmount(String id) {
    double sales = 0;
    final list = super.getList.where((e) => e.groupId == id).toList();
    if (list.isEmpty) return 0;

    for (Record record in list) {
      sales += record.totalAmount;
    }

    return sales;
  }
}
