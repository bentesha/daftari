import '../source.dart';

class ItemPage extends StatefulWidget {
  const ItemPage(this.item, {Key? key}) : super(key: key);

  final String item;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  _buildBody() {
    final titles = ['Drinking Water', 'Soft Drinks', 'Beverages', 'Milk'];
    return ListView(
      children: [
        _buildTitle(),
        Column(
            children: titles
                .map((e) => ItemTile(
                      e,
                      onPressed: () => _showBottomSheet(e, true),
                    ))
                .toList()),
      ],
    );
  }

  _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: AppText(widget.item, style: AppTextStyles.heading2)),
          Row(
            children: [
              AppIconButton(
                onPressed: () {},
                icon: Icons.add,
                iconColor: AppColors.primaryVariant,
              ),
              SizedBox(width: 15.dw),
              AppIconButton(
                onPressed: () => _showBottomSheet(widget.item, false),
                icon: Icons.more_horiz,
                iconColor: AppColors.primaryVariant,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showBottomSheet(String title, bool isTappedFromItem) {
    _scaffoldKey.currentState!.showBottomSheet((context) => Container(
          color: AppColors.secondary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SheetOpeningTile(),
              Padding(
                padding: EdgeInsets.only(left: 19.dw, top: 15.dh),
                child: AppText(title,
                    style: AppTextStyles.heading
                        .copyWith(color: AppColors.onPrimary)),
              ),
              AppDivider(color: AppColors.onPrimary, height: 2.dw),
              _buildTextButton(isTappedFromItem ? 'Edit' : 'Rename'),
              _buildTextButton('Delete'),
              _buildTextButton('Close', textColor: AppColors.accent),
            ],
          ),
        ));
  }

  _buildTextButton(String text, {Color? textColor}) {
    return AppTextButton(
      onPressed: () => Navigator.pop(context),
      height: 40.dh,
      padding: EdgeInsets.only(left: 19.dw),
      text: text,
      alignment: Alignment.centerLeft,
      isFilled: false,
      textStyle:
          AppTextStyles.body2.copyWith(color: textColor ?? AppColors.onPrimary),
    );
  }
}
