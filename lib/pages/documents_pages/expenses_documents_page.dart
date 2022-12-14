import '../../source.dart';

class ExpensesDocumentsPage extends StatefulWidget {
  const ExpensesDocumentsPage({Key? key}) : super(key: key);

  @override
  State<ExpensesDocumentsPage> createState() => _ExpensesDocumentsPage();
}

class _ExpensesDocumentsPage extends State<ExpensesDocumentsPage> {
  var bloc = ExpensesPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: 'Expenses'),
        body: _buildBody(),
        floatingActionButton: _buildFloatingButton());
  }

  Widget _buildBody() {
    return BlocConsumer<ExpensesPagesBloc, ExpensePagesState>(
      bloc: bloc,
      listener: (_, state) {
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
      },
    );
  }

  Widget _buildLoading(ExpenseSupplements supp) => const AppLoadingIndicator();

  Widget _buildFailed(
      ExpenseSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(ExpenseSupplements supp) {
    final documents = supp.documents;
    if (documents.isEmpty) {
      return const EmptyStateWidget(message: emptyExpensesDocumentsMessage);
    }

    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (context, index) {
        final document = documents[index];
        return document.maybeWhen(
            expenses: (_, __) => DocumentTile<Expense>(document),
            orElse: () => Container());
      },
      shrinkWrap: true,
    );
  }

  _buildFloatingButton() {
    return BlocBuilder<ExpensesPagesBloc, ExpensePagesState>(
        bloc: bloc,
        builder: (_, state) {
          final shouldShowButton = state.maybeWhen(
              content: (_) => true,
              failed: (_, __, showOnPage) => !showOnPage,
              orElse: () => false);
          if (!shouldShowButton) return Container();
          return const AddButton(nextPage: DocumentExpensesPage());
        });
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final categoriesService = getService<CategoriesService>(context);
      final expensesService = getService<ExpensesService>(context);
      bloc = ExpensesPagesBloc(expensesService, categoriesService);
    }
    bloc.init(Pages.expenses_documents_page);
  }

  _tryInitAgain() => _initBloc(false);

  static const emptyExpensesDocumentsMessage =
      'No expense record has been added. Add one by clicking the button on a bottom-right corner.';
}
