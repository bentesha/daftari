import '../source.dart';

class RecordDialog extends StatelessWidget {
  const RecordDialog({Key? key, required this.itemList}) : super(key: key);

  final List<Item> itemList;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.dw),
      child: SizedBox(
        width: ScreenSizeConfig.getFullWidth,
        height: 450.dh,
        child: itemList.isEmpty
            ? _buildEmptyState()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  DayText(color: AppColors.onBackground),
                ],
              ),
      ),
    );
  }

  _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            Constants.kEmptySalesImage,
            height: 100.dh,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.dh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.dw),
            child: const AppText(
                'You have not added any items. Click the button below to add items'),
          ),
          SizedBox(height: 20.dh),
          Builder(
            builder: (context) {
              return AppTextButton(
                onPressed:() => ItemEditPage.navigateTo(context),
                height: 40.dh,
                text: 'Add Item',
                margin: EdgeInsets.symmetric(horizontal: 19.dw),
              );
            }
          )
        ],
      ),
    );
  }
}
