import '../source.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage(this.documentPageAction, {this.expense, Key? key})
      : super(key: key);

  final Expense? expense;
  final PageActions documentPageAction;

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late final ExpensesPagesBloc bloc;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpensesPagesBloc, ExpensePagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);
          if (isSuccessful) pop();

          final error = state.maybeWhen(
              failed: (_, e, showOnPage) => showOnPage ? null : e,
              orElse: () => null);
          if (error != null) showSnackBar(error, context: context);
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildLoading(ExpenseSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      ExpenseSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(message!),
        AppTextButton(
            onPressed: _initBloc,
            text: 'Try Again',
            textColor: AppColors.onPrimary,
            backgroundColor: AppColors.primary,
            margin: EdgeInsets.only(top: 10.dh))
      ],
    ));
  }

  Widget _buildContent(ExpenseSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(ExpenseSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Category',
          value: supp.category.name,
          error: supp.errors['category'],
          isEditable: !supp.isViewing,
          onPressed: () => push(
              ItemsSearchPage<Category>(categoryType: CategoryType.expenses())),
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            text: supp.amount,
            onChanged: bloc.updateAmount,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Amount',
            error: supp.errors['amount'],
            isUpdatingOnRebuild: true,
            isEnabled: !supp.isViewing),
        AppTextField(
            text: supp.description,
            onChanged: bloc.updateAmount,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Description',
            error: supp.errors['description'],
            isUpdatingOnRebuild: true,
            isEnabled: !supp.isViewing),
      ],
    );
  }

  _buildAppBar(ExpenseSupplements supp) {
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    return PageAppBar(
        title: supp.isAdding
            ? 'New Expense Record'
            : supp.isViewing
                ? 'Expense Record'
                : 'Edit Expense Record',
        actionIcons: wasViewingDocument
            ? []
            : supp.isViewing
                ? [Icons.edit_outlined, Icons.delete_outlined]
                : [Icons.check],
        actionCallbacks: wasViewingDocument
            ? []
            : supp.isViewing
                ? [updateActionCallback, bloc.deleteExpense]
                : [supp.isEditing ? bloc.editExpense : bloc.addExpense]);
  }

  _initBloc() {
    final categoriesService = getService<CategoriesService>(context);
    final expensesService = getService<ExpensesService>(context);
    bloc = ExpensesPagesBloc(expensesService, categoriesService);
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.expense_page, expense: widget.expense, action: action);
  }
}