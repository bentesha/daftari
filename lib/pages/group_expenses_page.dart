import 'package:inventory_management/widgets/bottom_total_amount_tile.dart';

import '../source.dart';

class GroupExpensesPage extends StatefulWidget {
  const GroupExpensesPage({this.group, Key? key}) : super(key: key);

  final Group? group;

  @override
  State<GroupExpensesPage> createState() => _GroupExpensesPageState();
}

class _GroupExpensesPageState extends State<GroupExpensesPage> {
  late final ExpensePagesBloc bloc;
  late final bool isEditing;
  final _actionActiveNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    isEditing = widget.group != null;
    final expensesService = getService<ExpensesService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final groupsService = getService<GroupsService>(context);
    bloc = ExpensePagesBloc(expensesService, categoriesService, groupsService);
    _initAppAction();
    bloc.init(Pages.group_expenses_page, null, widget.group?.id);
    super.initState();
  }

  _initAppAction() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.group != null) _actionActiveNotifier.value = false;
      if (widget.group == null) _actionActiveNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildAddButton(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: AppText('Expenses',
            size: 22.dw, style: Theme.of(context).appBarTheme.titleTextStyle!),
        actions: [_buildAction()]);
  }

  Widget _buildBody() {
    return BlocBuilder<ExpensePagesBloc, ExpensePagesState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
          loading: _buildLoading,
          content: _buildContent,
          success: _buildContent,
        );
      },
    );
  }

  Widget _buildLoading(ExpenseSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ExpenseSupplements supp) {
    return ListView(
      children: [
        DateSelector(
            title: 'Date',
            onDateSelected: bloc.updateGroupDate,
            isEditable: true,
            date: supp.group.date),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            error: supp.errors['title'],
            text: supp.group.title,
            onChanged: bloc.updateGroupTitle,
            hintText: '',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'GROUP TITLE'),
        _buildItems(supp),
      ],
    );
  }

  _buildItems(ExpenseSupplements supp) {
    final expenses = supp.expenses;
    if (supp.group.id.isEmpty) return _buildEmptyState(emptyGroupMessage);
    if (expenses.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19.dw),
          child: const AppText('Expenses', weight: FontWeight.bold),
        ),
        ListView.separated(
          itemCount: expenses.length,
          separatorBuilder: (_, __) =>
              const AppDivider(margin: EdgeInsets.zero),
          itemBuilder: (_, i) {
            final expense = expenses[i];
            final category = bloc.getCategoryById(expense.categoryId);
            return ExpenseTile(expense, category: category);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 500.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
  }

  _buildAddButton() {
    return BlocBuilder<ExpensePagesBloc, ExpensePagesState>(
        bloc: bloc,
        builder: (_, state) {
          final hasNoGroup = state.supplements.group.id.isEmpty;
          if (hasNoGroup) return Container();
          return AddButton(
              nextPage: ExpenseEditPage(groupId: widget.group?.id));
        });
  }

  _buildBottomNavBar() {
    return BlocBuilder<ExpensePagesBloc, ExpensePagesState>(
        bloc: bloc,
        builder: (_, state) {
          final totalAmount = widget.group != null
              ? bloc.getAmountByGroup(widget.group!.id) ?? 0.0
              : 0.0;
          if (totalAmount == 0) return Container(height: .0001);
          return BottomTotalAmountTile(totalAmount);
        });
  }

  _buildAction() {
    return ValueListenableBuilder<bool>(
        valueListenable: _actionActiveNotifier,
        builder: (_, isActive, child) {
          return AppIconButton(
              icon: isActive ? Icons.done : Icons.edit_outlined,
              margin: EdgeInsets.only(right: 19.dw),
              onPressed: !isActive
                  ? () => _actionActiveNotifier.value = true
                  : isEditing
                      ? () {
                          bloc.editGroup();
                          _actionActiveNotifier.value = false;
                        }
                      : () {
                          bloc.saveGroup();
                          _actionActiveNotifier.value = false;
                        });
        });
  }

  static const emptyExpensesMessage = 'No items have been added yet.';
  static const emptyGroupMessage = 'Start by creating a new group.';
}
