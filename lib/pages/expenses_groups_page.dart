import '../widgets/expenses_group_tile.dart';
import 'group_expenses_page.dart';
import '../source.dart';

class ExpensesGroupsPage extends StatefulWidget {
  const ExpensesGroupsPage({Key? key}) : super(key: key);

  @override
  State<ExpensesGroupsPage> createState() => _ExpensesGroupsPageState();
}

class _ExpensesGroupsPageState extends State<ExpensesGroupsPage> {
  late final ExpensePagesBloc bloc;

  @override
  void initState() {
    final expensesService = getService<ExpensesService>(context);
    final categoriesService = getService<CategoriesService>(context);
    final groupsService = getService<GroupsService>(context);
    bloc = ExpensePagesBloc(expensesService, categoriesService, groupsService);
    bloc.init(Pages.expenses_groups_page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildBody(),
        appBar: const PageAppBar(title: 'Expenses'),
        floatingActionButton: const AddButton(nextPage: GroupExpensesPage()));
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
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
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
