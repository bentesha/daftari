import '../source.dart';

class RecordEditPage extends StatefulWidget {
  const RecordEditPage({this.groupId, this.record, Key? key}) : super(key: key);

  final String? groupId;
  final Record? record;

  @override
  State<RecordEditPage> createState() => _RecordEditPageState();
}

class _RecordEditPageState extends State<RecordEditPage> {
  late final RecordsPageBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    isEditing = widget.record != null;
    _initBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'New Record' : 'Edit Record',
          actionCallbacks: isEditing ? [bloc.editRecord] : [bloc.saveRecord]),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<RecordsPageBloc, RecordsPageState>(
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

  Widget _buildLoading(RecordsSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(RecordsSupplements supp) {
    return Column(
      children: [
        ValueSelector(
          title: 'Product',
          value: bloc.getSelectedProduct?.name,
          error: supp.errors['product'],
          isEditable: !isEditing,
          onPressed: () => push(
              ItemsSearchPage<Product>(categoryType: CategoryType.products())),
        ),
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: !isEditing,
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 5.dh)),
        SizedBox(height: 6.dh),
        AppTextField(
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: 'Quantity sold',
          keyboardType: TextInputType.number,
          label: 'Quantity',
          error: supp.errors['quantity'],
          isUpdatingOnRebuild: true,
        ),
        AppTextField(
          text: supp.sellingPrice,
          onChanged: bloc.updateAmount,
          hintText: 'Item selling price',
          keyboardType: TextInputType.number,
          label: 'Price per item',
          error: supp.errors['price'],
          isUpdatingOnRebuild: true,
        ),
        AppTextField(
          error: supp.errors['notes'],
          text: supp.notes,
          onChanged: bloc.updateNotes,
          hintText: 'Record notes',
          keyboardType: TextInputType.multiline,
          label: 'Notes',
          maxLines: 3,
        ),
      ],
    );
  }

  _initBloc() {
    final recordsService = getService<RecordsService>(context);
    final itemsService = getService<ProductsService>(context);
    bloc = RecordsPageBloc(recordsService, itemsService);
    bloc.init(widget.groupId, widget.record);
  }
}
