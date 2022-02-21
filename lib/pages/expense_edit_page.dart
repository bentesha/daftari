import '../source.dart';

class ExpenseEditPage extends StatefulWidget {
  const ExpenseEditPage(this.expense, {Key? key}) : super(key: key);

  final Expense? expense;

  @override
  State<ExpenseEditPage> createState() => _ExpenseEditPageState();
}

class _ExpenseEditPageState extends State<ExpenseEditPage> {
  late final RecordsPageBloc bloc;
  late final bool isEditing;

  @override
  void initState() {
    final recordsService = Provider.of<RecordsService>(context, listen: false);
    final itemsService = Provider.of<ProductsService>(context, listen: false);
    bloc = RecordsPageBloc(recordsService, itemsService);
    //bloc.init(widget.expense);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
          title: !isEditing ? 'Adding New Record' : 'Editing Record',
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
          title: 'Category',
          value: bloc.getSelectedProduct?.name,
          error: supp.errors['item'],
          isEditable: !isEditing,
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ItemsSearchPage<Product>())),
        ),
        DateSelector(
          title: 'Date',
          onDateSelected: bloc.updateDate,
          date: supp.date,
          isEditable: true,
        ),
        AppDivider(margin: EdgeInsets.only(bottom: 5.dh)),
        SizedBox(height: 6.dh),
        AppTextField(
          text: supp.quantity,
          onChanged: bloc.updateQuantity,
          hintText: '',
          keyboardType: TextInputType.number,
          label: 'Amount',
          error: supp.errors['amount'],
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
}
