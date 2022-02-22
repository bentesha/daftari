import '../source.dart';
import 'service.dart';

class GroupsService extends Service<Group> {
  static final _box = Hive.box(Constants.kGroupsBox);
  GroupsService() : super(_box);

  static var _selectedId = '';

  String get getEditedGroupId => _selectedId;
  List<Group> get getGroupList => super.getList;

  Group? getGroupById(String id) => _box.get(id) as Group?;

  ///Gets all groups from the Hive database
  void init() => super.getAll();

  Future<void> addGroup(Group group) async => await super.add(group);

  Future<void> editGroup(Group group) async {
    _selectedId = group.id;
    await super.edit(group);
  }
}
