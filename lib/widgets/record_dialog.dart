import '../source.dart';

class EmptyItemDialog extends StatelessWidget {
  const EmptyItemDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10.dw),
      child: SizedBox(
          width: ScreenSizeConfig.getFullWidth,
          height: 350.dh,
          child: _buildEmptyState()),
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
          SizedBox(height: 40.dh),
          Builder(builder: (context) {
            return AppTextButton(
              onPressed: () {
                Navigator.pop(context);
                ItemEditPage.navigateTo(context);
              },
              height: 40.dh,
              text: 'Add Item',
              margin: EdgeInsets.symmetric(horizontal: 19.dw),
            );
          })
        ],
      ),
    );
  }
}
