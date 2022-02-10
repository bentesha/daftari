import '../source.dart';

class GroupPagesBloc extends Cubit<GroupPagesState> {
  GroupPagesBloc(this.service) : super(GroupPagesState.initial());

  final GroupsService service;

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
    await service.addGroup(group);
    emit(GroupPagesState.success(supp));
  }

  _validate() {
    var supp = state.supplements;
    emit(GroupPagesState.loading(supp));

    final errors = <String, String?>{};
    if (!supp.isDateAsTitle) {
      errors['title'] = InputValidation.validateText(supp.title, 'Title');
    }
    supp = supp.copyWith(errors: errors);
    emit(GroupPagesState.content(supp));
  }
}
