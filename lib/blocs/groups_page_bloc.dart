import '../source.dart';

class GroupPagesBloc extends Cubit<GroupPagesState> {
  GroupPagesBloc(this.groupsService, this.recordsService, this.productsService)
      : super(GroupPagesState.initial()) {
    groupsService.addListener(() => _handleGroupListUpdates());
    productsService.addListener(() => _handleItemListUpdates());
    recordsService.addListener(() => _handleRecordsUpdates());
  }

  final GroupsService groupsService;
  final RecordsService recordsService;
  final ProductsService productsService;

  bool get isItemListEmpty => productsService.getProductList.isEmpty;

  double get getGroupTotalAmount {
    final supp = state.supplements;
    return recordsService.getRecordsTotalByGroup(supp.id);
  }

  void init({Group? group}) {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final groupList = groupsService.getAll();
    final groupsIdList = _getIdsFrom(groupList);
    recordsService.init();
    final groupAmounts = recordsService.getGroupsRecordsTotal(groupsIdList);
    final canUseDateAsTitle = _checkIfCanUseDateAsTitle(group);
    //  productsService.getAll();

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
        supp = supp.copyWith(errors: {'title_exists': titleErrorMessage});
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
    final canIgnoreValidation = supp.canUseDateAsTitle && supp.isDateAsTitle;
    if (!canIgnoreValidation) _validate();

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

  ///if it returns null then both options are true. Check the options below
  bool? _checkIfCanUseDateAsTitle([Group? group]) {
    final isEditing = group != null;

    final _date = group?.date ?? DateTime.now();
    final currentGroupList = groupsService.getGroupList;
    final currentDayGroupList = isEditing
        ? groupsService.getGroupList
            .where((e) => e.date.day == _date.day)
            .toList()
        : currentGroupList;

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

  _handleGroupListUpdates() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final editedGroupId = groupsService.getEditedGroupId;
    final title =
        groupsService.getGroupById(editedGroupId)?.title ?? supp.title;
    final groupList = groupsService.getGroupList;
    supp = supp.copyWith(groupList: groupList, title: title);
    emit(GroupPagesState.content(supp));
  }

  _handleItemListUpdates() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    productsService.getAll();
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
      'ONLY TWO RECORDING FORMATS ARE ALLOWED IN A DAY:\n\n1. Creating multiple custom-titled groups\n\n2. Using a respective day as a group for all sales records in that day';

  ///SCENARIOS                                                  Adding                         Editing
  ///used-date-as-title & alone-in-the-day                      ERROR                          ----can create a custom title
  ///didnot-use-date-as-title & alone-in-the-day                can create custom title        ----can create a custom title or Can use date as a title
  ///many-in-a-day                                              can create custom title        ----can create a custom title
}
