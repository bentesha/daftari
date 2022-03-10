import '../source.dart';
import 'service.dart';

class DocumentsService extends ChnageNotifier {
  DocumentsService() : super(_box);

  static var _selectedId = '';
  String get getEditedGroupId => _selectedId;

  ///Gets all groups from the Hive database
  void init() => super.getAll();

  Future<void> editGroup(Document group) async {
    _selectedId = group.form.id;
    await super.edit(group);
  }
}
