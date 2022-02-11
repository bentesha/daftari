import '../source.dart';

class GroupsService extends ChangeNotifier {
  final _box = Hive.box(Constants.kGroupsBox);
  final _groupList = <Group>[];

  List<Group> get getGroupList => _groupList;

  List<Group> getAll() {
    if (_box.isEmpty) return [];

    for (Group group in _box.values) {
      final index = _groupList.indexWhere((e) => e.id == group.id);
      if (index == -1) _groupList.add(group);
    }

    return _groupList;
  }

  Future<void> addGroup(Group group) async {
    await _box.put(group.id, group);
    _groupList.add(group);
    notifyListeners();
  }
}
