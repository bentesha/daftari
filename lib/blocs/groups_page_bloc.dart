import '../source.dart';

class GroupPagesBloc extends Cubit<GroupPagesState> {
  GroupPagesBloc(this.groupsService, this.recordsService, this.itemsService)
      : super(GroupPagesState.initial()) {
    groupsService.addListener(() => _handleGroupListUpdates());
    itemsService.addListener(() => _handleItemListUpdates());
  }

  final GroupsService groupsService;
  final RecordsService recordsService;
  final ItemsService itemsService;

  bool get isItemListEmpty => itemsService.getItemList.isEmpty;

  void init({Group? group}) {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));
    final groupList = groupsService.getAll();
    itemsService.init();
    supp = supp.copyWith(groupList: groupList);

    if (group != null) {
      supp = supp.copyWith(id: group.id, title: group.title, date: group.date);
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

    final group =
        Group(date: supp.date, title: supp.title, id: Utils.getRandomId());
    await groupsService.addGroup(group);
    emit(GroupPagesState.success(supp));
  }

  void editGroup() async {}

  List<Record> get getSpecificGroupRecords {
    final supp = state.supplements;
    return supp.recordList.where((e) => e.groupId == supp.id).toList();
  }

  Map<int, double> get getRecordsTotalAmount =>
      recordsService.getAllRecordsTotal();

  double get getGroupTotalAmount {
    final supp = state.supplements;
    return recordsService.getRecordsTotalByGroup(supp.id);
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
}
