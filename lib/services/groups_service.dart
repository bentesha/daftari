import '../source.dart';

class GroupsService {
  final _box = Hive.box(Constants.kGroupsBox);
  var _groupList = <Group>[];

  List<Group> getAll() {
    _groupList = _box.values.toList() as List<Group>;
    return _groupList;
  }

  Group getById(String id) => _box.get(id);

  Future<void> addGroup(Group group) async {
    await _box.put(group.id, group);
    _groupList.add(group);
  }
}
