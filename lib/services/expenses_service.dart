import 'package:inventory_management/services/service.dart';
import '../source.dart';

class ExpensesService extends Service<Expense> {
  static final _box = Hive.box(Constants.kExpenseBox);
  ExpensesService() : super(_box);

  void init() {
    super.getAll();
    _getDayTotalAmounts();
  }

  final _dailyAmounts = <int, double>{};
  Map<int, double> get getDayTotalAmounts => _dailyAmounts;

  @override
  Future<void> add(var item) async {
    await _box.put(item.id, item);
    final groupIdAmount = _dailyAmounts[item.date.day] ?? 0;
    _dailyAmounts[item.date.day] = groupIdAmount + item.amount;

    super.refresh();
    notifyListeners();
  }

  @override
  Future<void> edit(var item) async {
    await _box.put(item.id, item);

    final index = super.getList.indexWhere((e) => e.id == item.id);
    final beforeEditExpenseAmount = super.getList[index].amount;
    final beforeEditDayAmount = _dailyAmounts[item.date.day]!;
    _dailyAmounts[item.date.day] =
        beforeEditDayAmount - beforeEditExpenseAmount + item.amount;

    super.refresh();
    notifyListeners();
  }

  void _getDayTotalAmounts() {
    final days = getDaysWithExpenses();
    for (int day in days) {
      _dailyAmounts[day] = _getExpensesAmountByDate(day);
    }
  }

  double _getExpensesAmountByDate(int day) {
    double expenses = 0;
    final list = super.getList.where((e) => e.date.day == day).toList();
    if (list.isEmpty) return 0;

    for (Expense expense in list) {
      expenses += expense.amount;
    }

    return expenses;
  }

  List<int> getDaysWithExpenses() {
    final days = <int>[];
    for (Expense expense in super.getList) {
      final day = expense.date.day;
      if (days.contains(day)) continue;
      days.add(day);
    }
    return days;
  }
}
