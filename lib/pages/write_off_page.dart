import '../source.dart';
import '../widgets/form_cell_item_picker.dart';

class WriteOffPage extends StatefulWidget {
  const WriteOffPage(this.documentPageAction, {this.writeOff, Key? key})
      : super(key: key);

  final WriteOff? writeOff;
  final PageActions documentPageAction;

  @override
  State<WriteOffPage> createState() => _WriteOffPageState();
}

class _WriteOffPageState extends State<WriteOffPage> {
  var bloc = WriteOffPagesBloc.empty();

  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteOffPagesBloc, WriteOffPagesState>(
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

  Widget _buildLoading(WriteOffSupplements supp) =>
      const AppLoadingIndicator.withScaffold();

  Widget _buildFailed(
      WriteOffSupplements supp, String? message, bool isShowOnPage) {
    if (!isShowOnPage) return _buildContent(supp);

    return OnScreenError(message: message!, tryAgainCallback: _tryInitAgain);
  }

  Widget _buildContent(WriteOffSupplements supp) {
    return Scaffold(appBar: _buildAppBar(supp), body: _buildBody(supp));
  }

  Widget _buildBody(WriteOffSupplements supp) {
    final action = supp.action;

    return Column(
      children: [
        FormCellItemPicker(
          label: 'Product',
          valueText: supp.product.name,
          errorText: supp.errors['product'],
          editable: !action.isViewing,
          onPressed: () => push(const ItemsSearchPage<Product>()),
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
            text: supp.quantity,
            onChanged: bloc.updateQuantity,
            hintText: '',
            keyboardType: TextInputType.number,
            label: 'Quantity',
            error: supp.errors['quantity'],
            isUpdatingOnRebuild: true,
            isEnabled: !action.isViewing)
      ],
    );
  }

  _buildAppBar(WriteOffSupplements supp) {
    final action = supp.action;
    final wasViewingDocument = widget.documentPageAction == PageActions.viewing;
    updateActionCallback() {
      bloc.updateAction(PageActions.editing);
    }

    final title = action.isAdding
        ? 'New Write-off Record'
        : action.isViewing
            ? 'Write-off Record'
            : 'Edit Write-off Record';

    return PageAppBar.onModelPage(
        title: title,
        action: action,
        wasViewingDocument: wasViewingDocument,
        updateActionCallback: updateActionCallback,
        deleteModelCallback: bloc.deleteWriteOff,
        saveModelCallback: bloc.addWriteOff,
        editModelCallback: bloc.editWriteOff);
  }

  _initBloc([bool isFirstTimeInit = true]) {
    if (isFirstTimeInit) {
      final writeOffsService = getService<WriteOffsService>(context);
      final productsService = getService<ProductsService>(context);
      bloc = WriteOffPagesBloc(writeOffsService, productsService);
    }
    final action = widget.documentPageAction == PageActions.editing
        ? PageActions.viewing
        : widget.documentPageAction;
    bloc.init(Pages.write_off_page, writeOff: widget.writeOff, action: action);
  }

  _tryInitAgain() => _initBloc(false);
}
