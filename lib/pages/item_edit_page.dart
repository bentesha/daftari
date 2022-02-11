import '../source.dart';

class ItemEditPage extends StatefulWidget {
  const ItemEditPage({Key? key}) : super(key: key);

  static void navigateTo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const ItemEditPage()));
  }

  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  late final ItemPageBloc bloc;

  @override
  void initState() {
    final itemsService = Provider.of<ItemsService>(context, listen: false);
    bloc = ItemPageBloc(itemsService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<ItemPageBloc, ItemPageState>(
          bloc: bloc,
          listener: (_, state) {
            final isSaved =
                state.maybeWhen(success: (_) => true, orElse: () => false);

            if (isSaved) Navigator.pop(context);
          },
          builder: (_, state) {
            return state.when(
                loading: _buildLoading,
                content: _buildContent,
                success: _buildContent);
          }),
    );
  }

  _buildAppBar() {
    return PageAppBar(title: 'Adding Item', actionCallback: bloc.saveItem);
  }

  Widget _buildLoading(ItemSupplements supp) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(ItemSupplements supp) {
    final errors = supp.errors;

    return ListView(padding: EdgeInsets.only(top: 19.dh), children: [
      AppTextField(
        text: supp.title,
        onChanged: bloc.updateTitle,
        hintText: 'e.g. Clothes',
        keyboardType: TextInputType.name,
        label: 'Title',
        error: errors['title'],
      ),
      Row(
        children: [
          Expanded(
            child: AppTextField(
              text: supp.unit,
              onChanged: bloc.updateUnit,
              hintText: 'ea.',
              keyboardType: TextInputType.name,
              shouldShowErrorText: false,
              label: 'Unit',
              error: errors['unit'],
            ),
          ),
          Expanded(
            child: AppTextField(
              text: supp.unitPrice,
              onChanged: bloc.updateUnitPrice,
              hintText: '0',
              keyboardType: TextInputType.number,
              shouldShowErrorText: false,
              label: 'Unit Price',
              error: errors['unitPrice'],
            ),
          ),
        ],
      ),
      _buildUnitTextFieldsErrors(errors),
      AppTextField(
        text: supp.quantity,
        onChanged: bloc.updateQuantity,
        hintText: '0',
        keyboardType: TextInputType.number,
        label: 'Quantity',
        error: errors['quantity'],
      ),
      _buildTotalOpeningValue(supp),
    ]);
  }

  _buildTotalOpeningValue(ItemSupplements supp) {
    if (!supp.canCalculateTotalPrice) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDivider(
          color: AppColors.secondary,
          margin: EdgeInsets.only(bottom: 10.dh),
          height: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.dw),
          child: const AppText('Opening Value', opacity: .7),
        ),
        Padding(
          padding: EdgeInsets.only(left: 19.dw, top: 10.dh),
          child: AppText(supp.getQuantityValue,
              weight: FontWeight.w500, size: 20.dw),
        )
      ],
    );
  }

  _buildUnitTextFieldsErrors(Map<String, String?> errors) {
    final hasUnitError = errors['unit'] != null;
    final hasUnitPriceError = errors['unitPrice'] != null;

    return Padding(
      padding: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 10.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasUnitError) _buildErrorText(errors['unit']!),
          if (hasUnitPriceError) _buildErrorText(errors['unitPrice']!),
        ],
      ),
    );
  }

  _buildErrorText(String error) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.dh),
      child: AppText('* $error', color: AppColors.error),
    );
  }
}
