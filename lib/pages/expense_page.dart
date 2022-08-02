import 'package:inventory_management/widgets/form_cell_item_picker.dart';
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
  var bloc = ExpensesPagesBloc.empty();
  late ExpensesService expensesService;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExpensesPagesBloc, ExpensePagesState>(
          bloc: bloc,
          listener: (_, state) {
            final isSuccessful =
                state.maybeWhen(success: (_) => true, orElse: () => false);
            if (isSuccessful) pop();

            final error = state.maybeWhen(
                failed: (_, e, showOnPage) => showOnPage ? null : e,
                orElse: () => null);
            if (error != null) showSnackBar(error, context: _);
          },
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                success: _buildContent,
                failed: _buildFailed);
          }),
    );
  }

  Widget _buildLoading(ExpenseSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      ExpenseSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(ExpenseSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(ExpenseSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        FormCellItemPicker(
          label: 'Category',
          valueText: supp.category.name,
          errorText: supp.errors['category'],
          editable: !action.isViewing,
          onPressed: () => push(const ItemsSearchPage<Category>(
              categoryType: CategoryTypes.expenses)),
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
            isEnabled: !action.isViewing),
        AppTextField(
            text: supp.description,
            onChanged: bloc.updateDescription,
            hintText: '',
            keyboardType: TextInputType.name,
            label: 'Description',
            maxLines: 3,
            error: supp.errors['description'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
      ],
    );
  }

  _buildAppBar(ExpenseSupplements supp) {
    final action = supp.action;
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    final title = action.isAdding
        ? 'New Expense Record'
        : action.isViewing
            ? 'Expense Record'
            : 'Edit Expense Record';

    return PageAppBar.onModelPage(
        title: title,
        action: action,
        wasViewingDocument: wasViewingDocument,
        updateActionCallback: updateActionCallback,
        deleteModelCallback: bloc.deleteExpense,
        saveModelCallback: bloc.addExpense,
        editModelCallback: bloc.editExpense);
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final categoriesService = getService<CategoriesService>(context);
      expensesService = getService<ExpensesService>(context);
      bloc = ExpensesPagesBloc(expensesService, categoriesService);
    }
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.expense_page, expense: widget.expense, action: action);
  }

  _tryInitAgain() => _initBloc(false);
}
