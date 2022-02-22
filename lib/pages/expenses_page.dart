import '../widgets/expenses_group_tile.dart';
import '../pages/day_expenses_page.dart';
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
    final groupsService = Provider.of<GroupsService>(context, listen: false);
    bloc = ExpensePagesBloc(expensesService, categoriesService, groupsService);
    bloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(),
        appBar: const PageAppBar(title: 'Expenses'),
        floatingActionButton: const AddButton(nextPage: DayExpensesPage()));
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
    if (supp.groups.isEmpty) {
      return const EmptyStateWidget(message: emptyGroupMessage);
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => const AppDivider(),
      itemBuilder: (_, i) {
        final group = supp.groups[i];
        final groupAmount = bloc.getAmountByGroup(group.id);
        return ExpensesGroupTile(group, groupAmount ?? 0);
      },
      itemCount: supp.groups.length,
    );
  }

  static const emptyGroupMessage =
      'No expense has been added. Add one by clicking the button on a bottom-right corner.';
}
