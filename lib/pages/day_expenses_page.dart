import '../source.dart';

class DayExpensesPage extends StatefulWidget {
  const DayExpensesPage(this.day, this.title, {Key? key}) : super(key: key);

  final int day;
  final String title;

  @override
  State<DayExpensesPage> createState() => _DayExpensesPageState();
}

class _DayExpensesPageState extends State<DayExpensesPage> {
  late final ExpensePagesBloc bloc;

  @override
  void initState() {
    final expensesService =
        Provider.of<ExpensesService>(context, listen: false);
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    bloc = ExpensePagesBloc(expensesService, categoriesService);
    bloc.init(null, widget.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(title: widget.title + ' Expenses'),
      body: _buildBody(),
    );
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
    log('updating');
    return ListView.separated(
      itemCount: supp.expenses.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (_, i) {
        final expense = supp.expenses[i];
        final category = bloc.getCategoryById(expense.categoryId);
        return ExpenseTile(expense, category: category);
      },
    );
  }
}
