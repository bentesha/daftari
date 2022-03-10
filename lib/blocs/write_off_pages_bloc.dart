import '../source.dart';

class WriteOffPagesBloc extends Cubit<WriteOffPagesState>
    with ServicesInitializer {
  WriteOffPagesBloc(this.writeOffService, this.writeOffTypeService,
      this.productsService, this.groupsService)
      : super(WriteOffPagesState.initial()) {
   /*  writeOffTypeService.addListener(() => _handleWriteOffTypeUpdates());
    writeOffService.addListener(() => _handleWriteOffUpdates());
    groupsService.addListener(() => _handleGroupUpdates());
    productsService.addListener(() => _handleProductUpdates()); */
  }

  final WriteOffsService writeOffService;
  final WriteOffsTypesService writeOffTypeService;
  final ProductsService productsService;
  final GroupsService groupsService;

  /* double? getAmountByGroup(String id) => writeOffService.getDayTotalAmounts[id];

  void init(Pages page, [WriteOff? writeOff, String? groupId]) {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    initServices(
        productsService: productsService,
        writeOffService: writeOffService,
        groupsService: groupsService);

    _initWriteOffsGroupsPage(page);
    _initGroupWriteOffsPage(page, groupId);
    _initWriteOffsEditPage(page, writeOff, groupId);
  }

  void saveWriteOff() {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(WriteOffPagesState.loading(supp));

    final writeOff = WriteOff(
        groupId: supp.group.id,
        quantity: double.parse(supp.quantity),
        product: supp.product,
        id: Utils.getRandomId());
    writeOffService.add(writeOff);
    emit(WriteOffPagesState.success(supp));
  }

  void editWriteOff() {
    _validate();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(WriteOffPagesState.loading(supp));
    final writeOff = WriteOff(
        groupId: supp.group.id,
        quantity: double.parse(supp.quantity),
        product: supp.product,
        id: supp.id);
    writeOffService.edit(writeOff);
    emit(WriteOffPagesState.success(supp));
  }

  void updateQuantity(String quantity) => _updateAttributes(quantity: quantity);

  void updateGroupTitle(String title) => _updateAttributes(title: title);

  void updateGroupDate(DateTime date) => _updateAttributes(groupDate: date);

  void saveGroup() async {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;

    emit(WriteOffPagesState.loading(supp));
    final group = Group(
        id: Utils.getRandomId(),
        date: supp.group.date,
        title: supp.group.title,
        type: supp.group.type);
    //copying the group-id
    supp = supp.copyWith(group: group);
    await groupsService.add(group);
    emit(WriteOffPagesState.content(supp));
  }

  void editGroup() async {
    _validateGroupDetails();

    var supp = state.supplements;
    final hasErrors = InputValidation.checkErrors(supp.errors);
    if (hasErrors) return;
    emit(WriteOffPagesState.loading(supp));
    await groupsService.edit(supp.group);
    emit(WriteOffPagesState.content(supp));
  }

  void _updateAttributes({
    String? quantity,
    DateTime? groupDate,
    String? title,
  }) {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    supp = supp.copyWith(
        group: supp.group.copyWith(title: title, date: groupDate),
        quantity: quantity ?? supp.quantity);
    emit(WriteOffPagesState.content(supp));
  }

  _validate([bool isValidatingGroupDetails = false]) {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));

    final errors = <String, String?>{};

    if (isValidatingGroupDetails) {
      errors['title'] = InputValidation.validateText(supp.group.title, 'Title');
      errors['type'] = InputValidation.validateText(supp.group.type, 'Type');
    } else {
      errors['product'] =
          InputValidation.validateText(supp.product.id, 'Product');
      errors['quantity'] =
          InputValidation.validateNumber(supp.quantity, 'Quantity');
    }

    supp = supp.copyWith(errors: errors);
    emit(WriteOffPagesState.content(supp));
  }

  _validateGroupDetails() => _validate(true);

  void _initWriteOffsGroupsPage(Pages page) {
    if (page != Pages.write_off_groups_page) return;

    var supp = state.supplements;
    final groups =
        groupsService.getList.where((e) => e.isWriteOffGroup).toList();
    final writeOffs = writeOffService.getList;
    supp = supp.copyWith(groups: groups, writeOffs: writeOffs);
    emit(WriteOffPagesState.content(supp));
  }

  void _initGroupWriteOffsPage(Pages page, [String? groupId]) {
    if (page != Pages.group_write_offs_page) return;

    var supp = state.supplements;
    if (groupId == null) {
      //is adding new group
      supp = WriteOffSupplements.empty();
    } else {
      //is viewing existing group
      final writeOffs =
          writeOffService.getList.where((e) => e.groupId == groupId).toList();
      final group = groupsService.getById(groupId);
      supp = supp.copyWith(writeOffs: writeOffs, group: group!);
    }
    emit(WriteOffPagesState.content(supp));
  }

  void _initWriteOffsEditPage(Pages page,
      [WriteOff? writeOff, String? groupId]) {
    if (page != Pages.write_offs_edit_page) return;

    var supp = state.supplements;
    if (groupId != null) {
      //is adding a new expense:
      supp = WriteOffSupplements.empty();
      supp = supp.copyWith(group: supp.group.copyWith(id: groupId));
    }
    if (writeOff != null) {
      //is editing existing expense
      supp = supp.copyWith(
        group: supp.group.copyWith(id: writeOff.groupId),
        quantity: writeOff.quantity.toString(),
        id: writeOff.id,
        product: writeOff.product,
      );
    }
    emit(WriteOffPagesState.content(supp));
  }

  _handleProductUpdates() {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    final product = productsService.getCurrent;
    supp = supp.copyWith(product: product);
    emit(WriteOffPagesState.content(supp));
  }

  ///handling selected write-off-type on write-off-edit-page
  _handleWriteOffTypeUpdates() {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    final writeOffType = writeOffTypeService.getSelectedType;
    supp = supp.copyWith(group: supp.group.copyWith(type: writeOffType.name));
    emit(WriteOffPagesState.content(supp));
  }

  ///handling expenses on the group-expenses-page
  _handleWriteOffUpdates() {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    var writeOffs = writeOffService.getList
        .where((e) => e.groupId == supp.group.id)
        .toList();
    supp = supp.copyWith(writeOffs: writeOffs);
    emit(WriteOffPagesState.content(supp));
  }

  ///handling write-offs groups on the write-offs-groups-page
  _handleGroupUpdates() {
    var supp = state.supplements;
    emit(WriteOffPagesState.loading(supp));
    var groups = groupsService.getList.where((e) => e.isWriteOffGroup).toList();
    supp = supp.copyWith(groups: groups);
    emit(WriteOffPagesState.content(supp));
  } */
}
