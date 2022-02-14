import '../source.dart';

class GroupPagesBloc extends Cubit<GroupPagesState> {
  GroupPagesBloc(this.groupsService, this.recordsService, this.itemsService)
      : super(GroupPagesState.initial()) {
    groupsService.addListener(() => _handleGroupListUpdates());
    itemsService.addListener(() => _handleItemListUpdates());
    recordsService.addListener(() => _handleRecordsUpdates());
  }

  final GroupsService groupsService;
  final RecordsService recordsService;
  final ItemsService itemsService;

  bool get isItemListEmpty => itemsService.getItemList.isEmpty;

  double get getGroupTotalAmount {
    final supp = state.supplements;
    return recordsService.getRecordsTotalByGroup(supp.id);
  }

  void init({Group? group}) {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final groupList = groupsService.getAll();
    final groupsIdList = _getIdsFrom(groupList);
    final groupAmounts = recordsService.getGroupsRecordsTotal(groupsIdList);
    itemsService.init();
    supp = supp.copyWith(groupList: groupList, groupAmounts: groupAmounts);

    if (group != null) {
      final recordList = recordsService.getRecordList
          .where((e) => e.groupId == group.id)
          .toList();
      supp = supp.copyWith(
          id: group.id,
          title: group.title,
          date: group.date,
          recordList: recordList);
    }
    emit(GroupPagesState.content(supp));
  }

  void updateDate(DateTime date) => _updateAttributes(null, date);

  void updateTitle(String title) => _updateAttributes(title);

  void updateDateAsTitle(bool? isDateAsTitle) =>
      _updateAttributes('', null, isDateAsTitle);

  void _updateAttributes([String? title, DateTime? date, bool? isDateAsTitle]) {
    var supp = state.supplements;

    emit(GroupPagesState.loading(supp));
    supp = supp.copyWith(
        title: title ?? supp.title,
        date: date ?? supp.date,
        isDateAsTitle: isDateAsTitle ?? supp.isDateAsTitle);
    emit(GroupPagesState.content(supp));
  }

  void saveGroup() async {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final title =
        supp.isDateAsTitle ? DateFormatter.convertToDOW(supp.date) : supp.title;

    final group =
        Group(date: supp.date, title: title!, id: Utils.getRandomId());
    await groupsService.addGroup(group);
    emit(GroupPagesState.success(supp));
  }

  void editGroup() async {}

  List<Record> get getSpecificGroupRecords {
    final supp = state.supplements;
    return supp.recordList.where((e) => e.groupId == supp.id).toList();
  }

  _validate() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));

    final errors = <String, String?>{};
    if (!supp.isDateAsTitle) {
      errors['title'] = InputValidation.validateText(supp.title ?? '', 'Title');
    }
    supp = supp.copyWith(errors: errors);
    emit(GroupPagesState.content(supp));
  }

  List<String> _getIdsFrom(List<Group> groupList) {
    final idList = <String>[];
    for (Group group in groupList) {
      idList.add(group.id);
    }
    return idList;
  }

  _handleGroupListUpdates() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final groupList = groupsService.getGroupList;
    supp = supp.copyWith(groupList: groupList);
    emit(GroupPagesState.content(supp));
  }

  ///Goal here is to rebuild the widget with the updates list so that the
  ///isItemListEmpty getter gets called again.
  _handleItemListUpdates() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    itemsService.init();
    emit(GroupPagesState.content(supp));
  }

  _handleRecordsUpdates() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final recordList = recordsService.getRecordList;
    final groupAmounts = recordsService.getGroupsTotalAmounts;
    supp = supp.copyWith(recordList: recordList, groupAmounts: groupAmounts);
    emit(GroupPagesState.content(supp));
  }
}
