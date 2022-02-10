import '../source.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({this.record, Key? key}) : super(key: key);

  final Record? record;

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late final RecordsPageBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    bloc = Provider.of<RecordsPageBloc>(context, listen: false);
    isEditing = widget.record != null;
    bloc.initRecord(record: widget.record);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'Adding New Record' : 'Editing Record',
          actionCallback: isEditing ? bloc.editRecord : bloc.saveRecord),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<RecordsPageBloc, RecordsPageState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful = state.maybeWhen(
              success: (_, page) => page == RecordPages.record_page,
              orElse: () => false);

          if (isSuccessful) Navigator.pop(context);
        },
        builder: (_, state) {
          return state.when(
            loading: _buildLoading,
            content: _buildContent,
            success: (s, _) => _buildContent(s),
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
          value: bloc.getSelectedItem,
          errors: supp.errors,
          errorName: 'item',
          isEditable: !isEditing,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ItemSearchPage())),
        ),
        ValueSelector(
          title: 'Date',
          value: DateFormatter.convertToDMY(supp.date),
          onPressed: () => _showDatePicker(supp.date),
          errors: const {},
          isEditable: !isEditing,
          errorName: '',
        ),
        const AppDivider(),
        SizedBox(height: 6.dh),
        AppTextField(
          errors: supp.errors,
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: 'Quantity sold',
          keyboardType: TextInputType.number,
          label: 'Quantity',
          errorName: 'quantity',
        ),
        AppTextField(
          errors: supp.errors,
          text: supp.sellingPrice,
          onChanged: bloc.updateAmount,
          hintText: 'Item selling price',
          keyboardType: TextInputType.number,
          label: 'Price per item',
          errorName: 'price',
        ),
        AppTextField(
          errors: supp.errors,
          text: supp.notes,
          onChanged: bloc.updateNotes,
          hintText: 'Record notes',
          keyboardType: TextInputType.multiline,
          label: 'Notes',
          errorName: 'notes',
          maxLines: 3,
        ),
        _buildDeleteRecord(),
      ],
    );
  }

  _showDatePicker(DateTime date) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030));

    if (selectedDate != null) bloc.updateDate(selectedDate);
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
}
