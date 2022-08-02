import 'package:inventory_management/widgets/type_selector_dialog.dart';

import '../widgets/date_picker_form_cell.dart';
import '../widgets/form_cell_item_picker.dart';
import '../source.dart';
import '../widgets/bottom_total_amount_tile.dart';
import '../utils/extensions.dart/write_off_type.dart';
import '../widgets/items_title.dart';

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
        bottomNavigationBar: BottomTotalAmountTile(supp.document.form.total));
  }

  _buildAppBar(WriteOffSupplements supp) {
    final action = supp.action;
    final title = action.isViewing
        ? supp.document.form.formattedDate
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
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // if (action.isEditing || action.isAdding)
        DatePickerFormCell(
          label: "Date",
          value: supp.date,
          enabled: action.isEditing || action.isAdding,
          onChanged: (value) {
            if (value == null) return;
            bloc.updateDate(value);
          },
        ),
        FormCellItemPicker(
            onPressed: () => _openTypesDialog(supp.type),
            valueText: supp.type.string,
            label: 'Type',
            errorText: supp.errors['type'],
            editable: action.isAdding),
        const AppDivider(margin: EdgeInsets.zero),
        SizedBox(height: 15.dh),
        ItemsListTitle(
            title: "ITEMS",
            enabled: action.isEditing || action.isAdding,
            onPressed: () => push(const WriteOffPage(PageActions.adding))),
        _buildItems(supp)
      ],
    );
  }

  _buildItems(WriteOffSupplements supp) {
    final writeOffList = supp.getWriteOffList;
    if (writeOffList.isEmpty) return _buildEmptyState(emptyExpensesMessage);

    return ListView.separated(
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

  void _openTypesDialog(WriteOffTypes currentType) {
    showDialog(
        context: context,
        builder: (_) {
          return TypeSelectorDialog<WriteOffTypes>(
            onSelected: bloc.updateType,
            currentType: currentType,
            title: 'CHOOSE WRITE-OFF TYPE',
          );
        });
  }
}
