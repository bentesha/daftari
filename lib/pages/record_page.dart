import '../source.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late final RecordsPageBloc bloc;

  @override
  void initState() {
    bloc = Provider.of<RecordsPageBloc>(context, listen: false);
    bloc.initRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: 'Adding New Record', actionCallback: bloc.saveRecord),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocConsumer<RecordsPageBloc, RecordsPageState>(
        bloc: bloc,
        listener: (_, state) {
          final isSuccessful =
              state.maybeWhen(success: (_, page) => page == RecordPages.record_page, orElse: () => false);

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
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ItemSearchPage())),
        ),
        ValueSelector(
          title: 'Date',
          value: DateFormatter.convertToDMY(supp.date),
          onPressed: () => _showDatePicker(supp.date),
          errors: const {},
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
          text: supp.quantity,
          onChanged: bloc.updateAmount,
          hintText: 'Item selling price',
          keyboardType: TextInputType.number,
          label: 'Amount',
          errorName: 'amount',
        ),
        AppTextField(
          errors: supp.errors,
          text: supp.quantity,
          onChanged: bloc.updateNotes,
          hintText: 'Record notes',
          keyboardType: TextInputType.number,
          label: 'Notes',
          errorName: 'notes',
        ),
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
}
