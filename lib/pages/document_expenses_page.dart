import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';
import '../widgets/date_picker_form_cell.dart';

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
        bottomNavigationBar: BottomTotalAmountTile(supp.document.form.total));
  }

  Widget _emptyWidget() => const SizedBox(height: .004, width: .0004);

  _buildAppBar(ExpenseSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.formattedDate
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
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (action.isEditing || action.isAdding)
          DatePickerFormCell(
            label: "Date",
            value: supp.date,
            onChanged: (value) {
              if (value == null) return;
              bloc.updateDate(value);
            },
          ),
        const AppDivider(margin: EdgeInsets.zero),
        SizedBox(height: 15.dh),
        AppTextField(
            text: supp.document.form.description,
            onChanged: bloc.updateNotes,
            hintText: '',
            keyboardType: TextInputType.text,
            label: 'Comment',
            error: supp.errors['comment'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing),
        _buildItemsTitle(),
        _buildItems(supp)
      ],
    );
  }

  _buildItemsTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("CATEGORIES", style: TextStyle(fontSize: 18)),
          AppIconButton(
              onPressed: () => push(const ExpensePage(PageActions.adding)),
              icon: Icons.add,
              margin: const EdgeInsets.only(bottom: 5),
              iconThemeData: const IconThemeData(color: AppColors.primary))
        ],
      ),
    );
  }

  _buildItems(ExpenseSupplements supp) {
    final expenseList = supp.getExpenseList;
    if (expenseList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return ListView.separated(
      itemCount: expenseList.length,
      separatorBuilder: (_, __) => AppDivider.onDocumentPage(),
      itemBuilder: (_, i) {
        final expense = expenseList[i];
        final category = bloc.getCategoryById(expense.categoryId);
        return ExpenseTile(expense,
            category: category, documentPageAction: supp.action);
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );
  }

  _buildEmptyState(String message) {
    return Container(
        height: 600.dh,
        alignment: Alignment.center,
        child: EmptyStateWidget(message: message));
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
