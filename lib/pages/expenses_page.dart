import 'package:inventory_management/pages/day_expenses_page.dart';

import '../source.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late final ExpensePagesBloc bloc;

  @override
  void initState() {
    final expensesService =
        Provider.of<ExpensesService>(context, listen: false);
    final categoriesService =
        Provider.of<CategoriesService>(context, listen: false);
    bloc = ExpensePagesBloc(expensesService, categoriesService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: const PageAppBar(title: 'Expenses'),
      floatingActionButton: const AddButton(nextPage: ExpenseEditPage()),
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
    final expenseList = supp.expenses;
    if (expenseList.isEmpty) {
      return const EmptyStateWidget(message: emptyGroupMessage);
    }

    final daysWithExpenses = bloc.getDaysWithExpenses;

    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(),
      itemBuilder: (_, i) {
        final day = daysWithExpenses[i];
        final dayExpenses =
            expenseList.where((e) => e.date.day == day).toList();
        if (dayExpenses.isEmpty) return Container();
        return _buildDayExpenses(dayExpenses);
      },
      itemCount: daysWithExpenses.length,
    );
  }

  Widget _buildDayExpenses(List<Expense> expenseList) {
    final date = expenseList.first.date;
    final formattedDay = DateFormatter.convertToDOW(date);
    final amount = bloc.getAmountByDay(date.day);
    final formattedAmount = Utils.convertToMoneyFormat(amount ?? 0);
    return AppMaterialButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => DayExpensesPage(date.day, formattedDay))),
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(formattedDay),
        trailing: AppText(formattedAmount, weight: FontWeight.bold),
      ),
    );
  }

  static const emptyGroupMessage =
      'No expense has been added. Add one by clicking the button on a bottom-right corner.';
}
