import 'package:inventory_management/services/service.dart';
import '../source.dart';

class ExpensesService extends Service<Expense> {
  static final _box = Hive.box(Constants.kExpenseBox);
  ExpensesService() : super(_box);

  void init() {
    super.getAll();
    _getDayTotalAmounts();
  }

  final _dailyAmounts = <String, double>{};
  Map<String, double> get getDayTotalAmounts => _dailyAmounts;

  @override
  Future<void> add(var item) async {
    await _box.put(item.id, item);
    final groupIdAmount = _dailyAmounts[item.groupId] ?? 0;
    _dailyAmounts[item.groupId] = groupIdAmount + item.amount;

    super.refresh();
    notifyListeners();
  }

  @override
  Future<void> edit(var item) async {
    await _box.put(item.id, item);

    final index = super.getList.indexWhere((e) => e.id == item.id);
    final beforeEditExpenseAmount = super.getList[index].amount;
    final beforeEditDayAmount = _dailyAmounts[item.groupId]!;
    _dailyAmounts[item.groupId] =
        beforeEditDayAmount - beforeEditExpenseAmount + item.amount;

    super.refresh();
    notifyListeners();
  }

  void _getDayTotalAmounts() {
    final groupsIds = _getGroupsIds();
    for (String id in groupsIds) {
      final dayAmount = _getExpensesAmountByDay(id);
      _dailyAmounts[id] = dayAmount;
    }
  }

  double _getExpensesAmountByDay(String id) {
    double expenses = 0;
    final list = super.getList.where((e) => e.groupId == id).toList();
    if (list.isEmpty) return 0;

    for (Expense expense in list) {
      expenses += expense.amount;
    }

    return expenses;
  }

  List<String> _getGroupsIds() {
    final idList = <String>[];
    for (Expense expense in super.getList) {
      if (idList.contains(expense.groupId)) continue;
      idList.add(expense.groupId);
    }
    return idList;
  }
}
