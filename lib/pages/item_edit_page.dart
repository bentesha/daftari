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
  late final ItemsService service;

  @override
  void initState() {
    final service = Provider.of<ItemsService>(context, listen: false);
    bloc = ItemPageBloc(service);
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
    return AppBar(
      title: AppText('Adding Item',
          size: 22.dw, style: Theme.of(context).appBarTheme.titleTextStyle!),
      actions: [
        AppIconButton(
            onPressed: bloc.saveItem,
            icon: Icons.done,
            margin: EdgeInsets.only(right: 19.dw))
      ],
    );
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
        errors: errors,
        text: supp.title,
        onChanged: bloc.updateTitle,
        hintText: '',
        keyboardType: TextInputType.name,
        label: 'Title',
        errorName: 'title',
      ),
      Row(
        children: [
          Expanded(
            child: AppTextField(
              errors: errors,
              text: supp.unit,
              onChanged: bloc.updateUnit,
              hintText: '',
              keyboardType: TextInputType.name,
              label: 'Unit',
              errorName: 'unit',
            ),
          ),
          Expanded(
            child: AppTextField(
              errors: errors,
              text: supp.unitPrice,
              onChanged: bloc.updateUnitPrice,
              hintText: '',
              keyboardType: TextInputType.number,
              label: 'Unit Price',
              errorName: 'unitPrice',
            ),
          ),
        ],
      ),
      _buildUnitTextFieldsErrors(errors),
      AppTextField(
        errors: errors,
        text: supp.quantity,
        onChanged: bloc.updateQuantity,
        hintText: '',
        keyboardType: TextInputType.number,
        label: 'Quantity Sold',
        errorName: 'quantity',
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

  _buildUnitTextFieldsErrors(Map<String, String> errors) {
    final hasUnitError = errors.containsKey('unit');
    final hasUnitPriceError = errors.containsKey('unitPrice');

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
