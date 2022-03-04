import 'dart:convert';

import '../source.dart';
import 'package:http/http.dart' as http;

class NetworkService<T> extends ChangeNotifier {
  static const root = 'http://cloud.mobicap.co.tz:8080/';
  final headers = {"Content-Type": "application/json"};

  String get _path => T == Category ? 'category' : '';

  String get _url => root + _path + '/';

  final _list = [];
  List<T> get getList => _list.whereType<T>().toList();

  Future<List<T>> getAll([bool isRefreshing = false]) async {
    final response = await http.get(Uri.parse(_url));
    final results = json.decode(response.body);

    if (results.isEmpty) return [];

    for (var item in results) {
      final index = _list.indexWhere((e) => e.id == item['id']);
      if (index == -1) _list.add(Category.fromJson(item));
    }
    return _list.whereType<T>().toList();
  }

  ///updates the items list so that getList methods works for listeners
  void refresh() => getAll(true);

  T? getById(String id) {
    final items = _list.where((e) => e.id == id).toList();
    if (items.isNotEmpty) return items.first;
    return null;
  }

  Future<void> add(var item) async {
    final response = await http.post(Uri.parse(_url),
        body: json.encode(item.toJson()), headers: headers);
    log(response.body);
    _list.add(item);
    notifyListeners();
  }

  Future<void> edit(var item) async {
    // await _box.put(item.id, item);
    final index = _list.indexWhere((e) => e.id == item.id);
    _list[index] = item;
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await http.delete(Uri.parse(_url + '/$id'));
    final index = _list.indexWhere((e) => e.id == id);
    _list.removeAt(index);
    notifyListeners();
  }
}
