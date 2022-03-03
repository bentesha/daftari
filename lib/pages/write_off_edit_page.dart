import '../source.dart';

class WriteOffEditPage extends StatefulWidget {
  const WriteOffEditPage({this.writeOff, this.groupId, Key? key})
      : super(key: key);

  final WriteOff? writeOff;
  final String? groupId;

  @override
  State<WriteOffEditPage> createState() => _WriteOffEditPageState();
}

class _WriteOffEditPageState extends State<WriteOffEditPage> {
  late final WriteOffPagesBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.writeOff != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'New Write-Off' : 'Edit Write-Off',
          actionCallbacks:
              isEditing ? [bloc.editWriteOff] : [bloc.saveWriteOff]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<WriteOffPagesBloc, WriteOffPagesState>(
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
            success: _buildContent,
          );
        });
  }

  Widget _buildLoading(WriteOffSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(WriteOffSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: supp.product.name,
          error: supp.errors['product'],
          isEditable: !isEditing,
          onPressed: _navigateToProductsPicker,
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 10.dh)),
        AppTextField(
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Quantity',
          error: supp.errors['quantity'],
        ),
      ],
    );
  }

  _navigateToProductsPicker() => push(const ItemsSearchPage<Product>());

  _initBloc() {
    final groupsService = getService<GroupsService>(context);
    final writeOffsService = getService<WriteOffsService>(context);
    final writeOffsTypesService = getService<WriteOffsTypesService>(context);
    final productsService = getService<ProductsService>(context);
    bloc = WriteOffPagesBloc(writeOffsService, writeOffsTypesService,
        productsService, groupsService);
    bloc.init(Pages.write_offs_edit_page, widget.writeOff, widget.groupId);
  }
}
