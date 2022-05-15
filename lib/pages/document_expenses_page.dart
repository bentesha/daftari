import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';

class DocumentExpensesPage extends StatefulWidget {
  const DocumentExpensesPage(
      {this.document, this.fromQuickActions = false, Key? key})
      : super(key: key);

  final Document? document;
  final bool fromQuickActions;

  @override
  State<DocumentExpensesPage> createState() => _DocumentExpensesPageState();
}

class _DocumentExpensesPageState extends State<DocumentExpensesPage> {
  var bloc = ExpensesPagesBloc.empty();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _handlePop,
        child: BlocConsumer<ExpensesPagesBloc, ExpensePagesState>(
            bloc: bloc,
            listener: (_, state) {
              final isSuccessful =
                  state.maybeWhen(success: (_) => true, orElse: () => false);

              if (isSuccessful) {
                final message =
                    widget.fromQuickActions || state.supplements.action.isAdding
                        ? 'Sales document was added successfully'
                        : state.supplements.action.isEditing
                            ? 'Sales document was editted successfully'
                            : 'Sales document was deleted successfully';
                showSnackBar(message, context: _, isError: false);
                pop();
              }

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
      ),
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(supp),
        body: _buildGroupDetails(supp),
        floatingActionButton:
            widget.fromQuickActions ? _emptyWidget() : _buildActionButton(supp),
        bottomNavigationBar: widget.fromQuickActions
            ? _emptyWidget()
            : _buildBottomNavBar(supp));
  }

  Widget _emptyWidget() => const SizedBox(height: .004, width: .0004);

  _buildAppBar(ExpenseSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.title
        : action.isEditing
            ? 'Edit Expenses Document'
            : 'New Expenses Document';

    return PageAppBar.onDocumentPage(
        title: title,
        action: action,
        updateActionCallback: () => bloc.updateAction(PageActions.editing),
        deleteDocumentCallback: bloc.deleteDocument,
        saveDocumentCallback: () => bloc.saveDocument(widget.fromQuickActions),
        editDocumentCallback: bloc.editDocument);
  }

  Widget _buildGroupDetails(ExpenseSupplements supp) {
    final action = supp.action;

    return ListView(
      children: [
        action.isEditing || action.isAdding
            ? DateSelector(
                title: 'Date',
                onDateSelected: bloc.updateDate,
                date: supp.date,
                isEditable: false,
              )
            : Container(),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
        widget.fromQuickActions ? _emptyWidget() : _buildItems(supp)
      ],
    );
  }

  _buildGroupTitle(ExpenseSupplements supp) {
    return supp.action.isViewing
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckBox(supp),
              supp.isDateAsTitle
                  ? Container()
                  : AppTextField(
                      text: supp.document.form.title,
                      onChanged: bloc.updateTitle,
                      hintText: '',
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      label: 'Title',
                      error: supp.errors['title']),
            ],
          );
  }

  _buildCheckBox(ExpenseSupplements supp) {
    final text =
        supp.isDateAsTitle ? 'Date used as title' : 'Use date as title';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.dw),
      child: Row(
        children: [
          Checkbox(
              value: supp.isDateAsTitle, onChanged: bloc.updateDateAsTitle),
          SizedBox(width: 5.dw),
          AppText(text),
        ],
      ),
    );
  }

  _buildItems(ExpenseSupplements supp) {
    final expenseList = supp.getExpenseList;
    if (expenseList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        supp.action.isViewing
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 19.dw),
                child: const AppText('Expenses', weight: FontWeight.bold),
              ),
        ListView.separated(
          itemCount: expenseList.length,
          separatorBuilder: (_, __) => AppDivider.onDocumentPage(),
          itemBuilder: (_, i) {
            final expense = expenseList[i];
            final category = bloc.getCategoryById(expense.categoryId);
            return ExpenseTile(expense,
                category: category, documentPageAction: supp.action);
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 600.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
  }

  _buildActionButton(ExpenseSupplements supp) {
    return supp.action.isViewing
        ? Container()
        : const AddButton(nextPage: ExpensePage(PageActions.adding));
  }

  _buildBottomNavBar(ExpenseSupplements supp) {
    return supp.action.isViewing
        ? BottomTotalAmountTile(supp.document.form.total)
        : const SizedBox(height: .00001);
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final expensesService = getService<ExpensesService>(context);
      final categoriesService = getService<CategoriesService>(context);
      bloc = ExpensesPagesBloc(expensesService, categoriesService);
    }
    bloc.init(Pages.document_expenses_page, document: widget.document);
  }

  _tryInitAgain() => _initBloc(false);

  Future<bool> _handlePop() async {
    final hasUnSavedSales = bloc.documentHasUnsavedChanges;
    if (hasUnSavedSales) {
      showDialog(
          context: context,
          builder: (_) => DocumentAlertDialog(
                isEditing: widget.document != null,
                editDocumentCallback: bloc.editDocument,
                saveDocumentCallback: bloc.saveDocument,
                clearChangesCallback: bloc.clearChanges,
              ));
    }
    return true;
  }

  static const emptyExpensesMessage =
      'No expenses have been added in this document yet.';
}
