import '../source.dart';
import 'service.dart';

class GroupsService extends Service<Group> {
  static final box = Hive.box(Constants.kGroupsBox);
  GroupsService() : super(box);

  List<Group> get getGroupList => super.getList;

  Future<void> addGroup(Group group) async => super.add(group);

  Future<void> editGroup(Group group) async => super.edit(group);

  List<Group> init() => super.getAll();
}
