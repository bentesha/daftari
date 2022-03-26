import '../widgets/type_selector.dart';
import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';

class DocumentWriteOffsPage extends StatefulWidget {
  const DocumentWriteOffsPage([this.document, Key? key]) : super(key: key);

  final Document? document;

  @override
  State<DocumentWriteOffsPage> createState() => _DocumentWriteOffsPageState();
}

class _DocumentWriteOffsPageState extends State<DocumentWriteOffsPage> {
  var bloc = WriteOffPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePop,
      child: BlocConsumer<WriteOffPagesBloc, WriteOffPagesState>(
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
          }),
    );
  }

  Widget _buildLoading(WriteOffSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      WriteOffSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(WriteOffSupplements supp) {
    return Scaffold(
        appBar: _buildAppBar(supp),
        body: _buildGroupDetails(supp),
        floatingActionButton: _buildActionButton(supp),
        bottomNavigationBar: _buildBottomNavBar(supp));
  }

  _buildAppBar(WriteOffSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.title
        : action.isEditing
            ? 'Edit Write-off Document'
            : 'New Write-off Document';

    return PageAppBar.onDocumentPage(
        title: title,
        action: action,
        updateActionCallback: () => bloc.updateAction(PageActions.editing),
        deleteDocumentCallback: bloc.deleteDocument,
        saveDocumentCallback: bloc.saveDocument,
        editDocumentCallback: bloc.editDocument);
  }

  Widget _buildGroupDetails(WriteOffSupplements supp) {
    final action = supp.action;

    return ListView(
      children: [
        !action.isViewing
            ? DateSelector(
                title: 'Date',
                onDateSelected: bloc.updateDate,
                date: supp.date,
                isEditable: false)
            : Container(),
        TypeSelector(
            onTypeSelected: bloc.updateType,
            selectedType: supp.type,
            title: 'Type',
            error: supp.errors['type'],
            isEditable: action.isAdding),
        const AppDivider(margin: EdgeInsets.zero),
        _buildGroupTitle(supp),
        _buildItems(supp)
      ],
    );
  }

  _buildGroupTitle(WriteOffSupplements supp) {
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

  _buildCheckBox(WriteOffSupplements supp) {
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

  _buildItems(WriteOffSupplements supp) {
    final writeOffList = supp.getWriteOffList;
    if (writeOffList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 19.dw, top: 10.dh),
          child: const AppText('Items', weight: FontWeight.bold),
        ),
        ListView.separated(
          itemCount: writeOffList.length,
          separatorBuilder: (_, __) => AppDivider.onDocumentPage(),
          itemBuilder: (_, i) {
            final writeOff = writeOffList[i];
            final product = bloc.getProductById(writeOff.productId);
            return WriteOffTile(writeOff,
                product: product, documentPageAction: supp.action);
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

  _buildActionButton(WriteOffSupplements supp) {
    return supp.action.isViewing
        ? Container()
        : const AddButton(nextPage: WriteOffPage(PageActions.adding));
  }

  _buildBottomNavBar(WriteOffSupplements supp) {
    return supp.action.isViewing
        ? BottomTotalAmountTile(supp.document.form.total)
        : const SizedBox(height: .00001);
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final writeOffsService = getService<WriteOffsService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = WriteOffPagesBloc(writeOffsService, productsService);
    }
    bloc.init(Pages.document_write_offs_page, document: widget.document);
  }

  _tryInitAgain() => _initBloc(false);

  Future<bool> _handlePop() async {
    final hasUnSavedChanges = bloc.documentHasUnsavedChanges;
    if (hasUnSavedChanges) {
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
      'No write-offs have been added in this document yet.';
}
