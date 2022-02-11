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
    final recordsService = Provider.of<RecordsService>(context, listen: false);
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = RecordsPageBloc(recordsService, itemsService);
    isEditing = widget.record != null;
    bloc.init(widget.groupId, widget.record);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'Adding New Record' : 'Editing Record',
          actionCallback: isEditing ? bloc.editRecord : bloc.saveRecord),
      body: _buildBody(),
      floatingActionButton: _buildAddItemButton(),
    );
  }

  _buildBody() {
    return BlocConsumer<RecordsPageBloc, RecordsPageState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_) => true, orElse: () => false);

          if (isSuccessful) Navigator.pop(context);
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
          title: 'Item',
          value: bloc.getSelectedItem?.title,
          error: supp.errors['item'],
          isEditable: !isEditing,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ItemSearchPage())),
        ),
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: !isEditing,
        ),
        const AppDivider(),
        SizedBox(height: 6.dh),
        AppTextField(
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: 'Quantity sold',
          keyboardType: TextInputType.number,
          label: 'Quantity',
          error: supp.errors['quantity'],
        ),
        AppTextField(
          text: supp.sellingPrice,
          onChanged: bloc.updateAmount,
          hintText: 'Item selling price',
          keyboardType: TextInputType.number,
          label: 'Price per item',
          error: supp.errors['price'],
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
        _buildDeleteRecord(),
      ],
    );
  }

  _buildDeleteRecord() {
    return isEditing
        ? Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            AppTextButton(
                onPressed: () {},
                height: 40.dh,
                text: 'Delete',
                backgroundColor: AppColors.surface,
                textColor: AppColors.error,
                margin:
                    EdgeInsets.only(bottom: 20.dh, left: 15.dw, right: 15.dw))
          ]))
        : Container();
  }

  _buildAddItemButton() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const RecordEditPage())),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }
}
