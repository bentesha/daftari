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
    final salesService = getService<SalesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = SalesDocumentsPagesBloc(salesService, productsService);
    bloc.init(Pages.document_sales_page, document: widget.document);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesDocumentsPagesBloc, SalesDocumentsPagesState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              success: _buildContent);
        },
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) pop();
        });
  }

  Widget _buildContent(SalesDocumentSupplements supp) {
    final form = supp.document.form;
    final hasDocument = form.id.isNotEmpty;

    return Scaffold(
      appBar: PageAppBar(
          title: hasDocument ? form.title : 'New Sales Document',
          actionIcons: [hasDocument ? Icons.edit_outlined : Icons.done],
          actionCallbacks: hasDocument
              ? [/*bloc.editDocument*/ () {}]
              : [bloc.saveDocument]),
      body: _buildGroupDetails(supp),
      floatingActionButton: const AddButton(nextPage: SalesEditPage()),
      bottomNavigationBar: BottomTotalAmountTile(form.total),
    );
  }

  Widget _buildLoading(SalesDocumentSupplements supp) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildGroupDetails(SalesDocumentSupplements supp) {
    final hasDocument = supp.document.form.id.isNotEmpty;

    return ListView(
      children: [
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: /*!hasDocument*/ false,
        ),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
        _buildItems(supp)
      ],
    );
  }

  _buildGroupTitle(SalesDocumentSupplements supp) {
    return Column(
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.dw),
      child: Row(
        children: [
          Checkbox(
              value: supp.isDateAsTitle, onChanged: bloc.updateDateAsTitle),
          SizedBox(width: 5.dw),
          const AppText('Use date as the title'),
        ],
      ),
    );
  }

  _buildItems(SalesDocumentSupplements supp) {
    final document = supp.document;
    final sales =
        document.maybeWhen(sales: (_, s) => s, orElse: () => <Sales>[]);
    if (sales.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19.dw),
          child: const AppText('Sales', weight: FontWeight.bold),
        ),
        ListView.separated(
          itemCount: sales.length,
          separatorBuilder: (_, __) =>
              const AppDivider(margin: EdgeInsets.zero),
          itemBuilder: (_, i) => SalesTile(sales[i]),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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

  static const emptyExpensesMessage = 'No sales have been added yet.';
}
