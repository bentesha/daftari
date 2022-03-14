import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';

class DocumentSalesPage extends StatefulWidget {
  const DocumentSalesPage({this.document, Key? key}) : super(key: key);

  final Document? document;

  @override
  State<DocumentSalesPage> createState() => _DocumentSalesPageState();
}

class _DocumentSalesPageState extends State<DocumentSalesPage> {
  late final SalesDocumentsPagesBloc bloc;

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) pop();
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        });
  }

  Widget _buildLoading(SalesDocumentSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildContent(SalesDocumentSupplements supp) {
    return Scaffold(
      appBar: _buildAppBar(supp),
      body: _buildGroupDetails(supp),
      floatingActionButton: _buildActionButton(supp),
      bottomNavigationBar: _buildBottomNavBar(supp),
    );
  }

  _buildAppBar(SalesDocumentSupplements supp) {
    final title = supp.isViewing
        ? supp.document.form.title
        : supp.isEditing
            ? 'Edit Sales Document'
            : 'New Sales Document';

    return PageAppBar(
        title: title,
        actionIcons: supp.isViewing
            ? [Icons.edit_outlined, Icons.delete_outlined]
            : [Icons.done],
        actionCallbacks: supp.isViewing
            ? [
                () => bloc.updateAction(PageActions.editing),
                bloc.deleteDocument
              ]
            : [supp.isEditing ? bloc.editDocument : bloc.saveDocument]);
  }

  Widget _buildGroupDetails(SalesDocumentSupplements supp) {
    return ListView(
      children: [
        supp.isEditing || supp.isAdding
            ? DateSelector(
                title: 'Date',
                onDateSelected: bloc.updateDate,
                date: supp.date,
                isEditable: /*!hasDocument*/ false,
              )
            : Container(),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
        _buildItems(supp)
      ],
    );
  }

  _buildGroupTitle(SalesDocumentSupplements supp) {
    return supp.isViewing
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

  _buildCheckBox(SalesDocumentSupplements supp) {
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

  _buildItems(SalesDocumentSupplements supp) {
    final document = supp.document;
    final salesList =
        document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    if (salesList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        supp.isViewing
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 19.dw),
                child: const AppText('Sales', weight: FontWeight.bold),
              ),
        ListView.separated(
          itemCount: salesList.length,
          separatorBuilder: (_, __) =>
              const AppDivider(margin: EdgeInsets.zero),
          itemBuilder: (_, i) {
            final sales = salesList[i];
            final product = bloc.getProductById(sales.productId);
            final action = supp.isViewing ? supp.action : PageActions.editing;
            return SalesTile(sales, product: product, action: action);
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

  _buildActionButton(SalesDocumentSupplements supp) {
    return supp.isViewing
        ? Container()
        : const AddButton(nextPage: SalesPage(PageActions.adding));
  }

  _buildBottomNavBar(SalesDocumentSupplements supp) {
    return supp.isViewing
        ? BottomTotalAmountTile(supp.document.form.total)
        : const SizedBox(height: .00001);
  }

  _initBloc() {
    final salesService = getService<SalesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, productsService);
    bloc.init(Pages.document_sales_page, document: widget.document);
  }

  static const emptyExpensesMessage =
      'No sales have been added in this document yet.';
}
