import '../source.dart';

class Service<T> extends ChangeNotifier {
  final Box _box;
  Service(this._box);

  final _list = [];
  List<T> get getList => _list.whereType<T>().toList();

  List<T> getAll() {
    if (_box.isEmpty) return [];

    for (var item in _box.values) {
      final index = _list.indexWhere((e) => e.id == item.id);
      if (index == -1) _list.add(item);
    }

    return _list.whereType<T>().toList();
  }

  Future<void> add(var item) async {
    await _box.put(item.id, item);
    _list.add(item);
    notifyListeners();
  }

  Future<void> edit(var item) async {
    await _box.put(item.id, item);
    final index = _list.indexWhere((e) => e.id == item.id);
    _list[index] = item;
    notifyListeners();
  }
}
