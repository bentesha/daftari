import '../source.dart';

class DayExpensesPage extends StatefulWidget {
  const DayExpensesPage({this.group, Key? key}) : super(key: key);

  final Group? group;

  @override
  State<DayExpensesPage> createState() => _DayExpensesPageState();
}

class _DayExpensesPageState extends State<DayExpensesPage> {
  late final ExpensePagesBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.group != null;
    final expensesService =
        Provider.of<ExpensesService>(context, listen: false);
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    final groupsService = Provider.of<GroupsService>(context, listen: false);
    bloc = ExpensePagesBloc(expensesService, categoriesService, groupsService);
    bloc.init(null, widget.group?.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PageAppBar(
          title: 'Expenses',
          actionCallbacks: [isEditing ? bloc.editGroup : bloc.saveGroup],
          actionIcons: const [Icons.done],
        ),
        body: _buildBody(),
        floatingActionButton:
            AddButton(nextPage: ExpenseEditPage(groupId: widget.group?.id)));
  }

  Widget _buildBody() {
    return BlocConsumer<ExpensePagesBloc, ExpensePagesState>(
      bloc: bloc,
      listener: (_, state) {
        final isSaved =
            state.maybeWhen(success: (_) => true, orElse: () => false);

        if (isSaved) Navigator.pop(context);
      },
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
            onChanged: bloc.updateTitle,
            hintText: '',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            label: 'GROUP TITLE'),
        _buildItems(supp),
      ],
    );
  }

  _buildItems(ExpenseSupplements supp) {
    final hasExpenses = supp.group.id.isNotEmpty;
    log('${supp.group.id} and nothing is here');
    var expenses = <Expense>[];
    if (hasExpenses) expenses = supp.expenses;
    if (expenses.isEmpty) {
      return Container(
          height: 400.dh,
          alignment: Alignment.center,
          child: const EmptyStateWidget(message: emptyExpensesMessage));
    }
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

  static const emptyExpensesMessage = 'No items have been added yet.';
}
