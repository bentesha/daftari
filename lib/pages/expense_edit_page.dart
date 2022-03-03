import '../source.dart';

class ExpenseEditPage extends StatefulWidget {
  const ExpenseEditPage({this.expense, this.groupId, Key? key})
      : super(key: key);

  final Expense? expense;
  final String? groupId;

  @override
  State<ExpenseEditPage> createState() => _ExpenseEditPageState();
}

class _ExpenseEditPageState extends State<ExpenseEditPage> {
  late final ExpensePagesBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.expense != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'New Expense' : 'Edit Expense',
          actionCallbacks: isEditing ? [bloc.editExpense] : [bloc.saveExpense]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<ExpensePagesBloc, ExpensePagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) pop();
        },
        builder: (_, state) {
          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: _buildContent,
          );
        });
  }

  Widget _buildLoading(ExpenseSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ExpenseSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Category',
          value: supp.category.name,
          error: supp.errors['category'],
          isEditable: !isEditing,
          onPressed: _navigateToCategoryPicker,
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 5.dh)),
        SizedBox(height: 6.dh),
        AppTextField(
          text: supp.amount,
          onChanged: bloc.updateAmount,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Amount',
          error: supp.errors['amount'],
        ),
        AppTextField(
          error: supp.errors['notes'],
          text: supp.notes,
          onChanged: bloc.updateNotes,
          hintText: 'Record notes',
          keyboardType: TextInputType.multiline,
          label: 'Notes',
          maxLines: 3,
        ),
      ],
    );
  }

  _navigateToCategoryPicker() =>
      push(ItemsSearchPage<Category>(categoryType: CategoryType.expenses()));

  _initBloc() {
    final groupsService = getService<GroupsService>(context);
    final expensesService = getService<ExpensesService>(context);
    final categoriesService = getService<CategoriesService>(context);
    bloc = ExpensePagesBloc(expensesService, categoriesService, groupsService);
    bloc.init(Pages.expense_edit_page, widget.expense, widget.groupId);
  }
}
