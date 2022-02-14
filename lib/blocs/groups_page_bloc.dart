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
    final canUseDateAsTitle = _checkIfCanUseDateAsTitle(group);
    itemsService.init();

    log('can use date as title');
    log(canUseDateAsTitle.toString());

    supp = supp.copyWith(
        groupList: groupList,
        groupAmounts: groupAmounts,
        isDateAsTitle: canUseDateAsTitle ?? false,
        canUseDateAsTitle: canUseDateAsTitle ?? true);

    if (group != null) {
      final recordList = recordsService.getRecordList
          .where((e) => e.groupId == group.id)
          .toList();
      supp = supp.copyWith(
          id: group.id,
          title: group.title,
          date: group.date,
          recordList: recordList);
    } else {
      final doesTitleExist = _checkIfGroupTitleExists();
      if (doesTitleExist) {
        supp = supp.copyWith(errors: {'TitleExists': titleErrorMessage});
        emit(GroupPagesState.content(supp));
      }
    }
    emit(GroupPagesState.content(supp));
  }

  bool _checkIfGroupTitleExists() {
    final dateTitle = DateFormatter.convertToDOW(DateTime.now());
    final group =
        groupsService.getGroupList.where((e) => e.title == dateTitle).toList();
    return group.isNotEmpty;
  }

  ///if it returns null then both options are true.
  bool? _checkIfCanUseDateAsTitle([Group? group]) {
    final isEditing = group != null;

    final _date = group?.date ?? DateTime.now();
    final currentGroupList = groupsService.getGroupList;
    final currentDayGroupList = isEditing
        ? groupsService.getGroupList
            .where((e) => e.date.day == _date.day)
            .toList()
        : currentGroupList;

    log(currentDayGroupList.toString());

    final dayNumberOfGroups = currentDayGroupList.length;
    if (dayNumberOfGroups == 1) {
      final title = currentDayGroupList.first.title;
      final didUseDateAsTitle = title == DateFormatter.convertToDOW(_date);
      if (didUseDateAsTitle && isEditing) return false;
      if (!didUseDateAsTitle && !isEditing) return false;
      if (!didUseDateAsTitle && isEditing) return null;
    }
    if (dayNumberOfGroups > 1) return false;
    return true;
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

    final group = Group(date: supp.date, title: title, id: Utils.getRandomId());
    await groupsService.addGroup(group);
    emit(GroupPagesState.success(supp));
  }

  void editGroup() async {
    var supp = state.supplements;
    supp = supp.copyWith(errors: {});
    log(supp.canUseDateAsTitle.toString());
    log(supp.isDateAsTitle.toString());
    if (supp.canUseDateAsTitle && supp.isDateAsTitle) {
    } else {
      _validate();
    }

    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    final isEditing = supp.id.trim().isNotEmpty;
    final title = isEditing
        ? supp.canUseDateAsTitle && supp.isDateAsTitle
            ? DateFormatter.convertToDOW(supp.date)
            : supp.title
        : supp.isDateAsTitle
            ? DateFormatter.convertToDOW(supp.date)
            : supp.title;

    final group = Group(date: supp.date, title: title, id: supp.id);
    await groupsService.editGroup(group);
    emit(GroupPagesState.success(supp));
  }

  List<Record> get getSpecificGroupRecords {
    final supp = state.supplements;
    return supp.recordList.where((e) => e.groupId == supp.id).toList();
  }

  _validate() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));

    final errors = <String, String?>{};
    final isEditing = supp.id.trim().isNotEmpty;
    if (!supp.isDateAsTitle || isEditing) {
      errors['title'] = InputValidation.validateText(supp.title, 'Title');
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

  static const titleErrorMessage =
      'The title for today is already taken, because the current group was named with date as its title.\n\n Two options: \nAdd another record in the group you already created \n OR \n Rename the group that already exists using a custom title.';
}
