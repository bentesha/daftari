import '../source.dart';

class TypeSelector extends StatelessWidget {
  const TypeSelector(
      {Key? key,
      required this.onTypeSelected,
      required this.selectedType,
      required this.title,
      required this.isEditable})
      : super(key: key);

  final ValueChanged<WriteOffTypes> onTypeSelected;
  final WriteOffTypes? selectedType;
  final String title;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      backgroundColor: AppColors.surface,
      onPressed: isEditable ? () => _showOptionsDialog(context) : () {},
      isFilled: false,
      padding: EdgeInsets.symmetric(horizontal: 19.dw),
      child: ListTile(
        title: AppText(title.toUpperCase(), opacity: .7),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 5.dh),
          child: AppText(selectedType?.string ?? 'Tap to select',
              weight: FontWeight.w500),
        ),
        trailing:
            isEditable ? const Icon(Icons.chevron_right) : Container(width: .1),
      ),
    );
  }

  _showOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: SizedBox(
              height: 205.dh,
              child: Column(
                children: [_buildTitle(), _buildOptions()],
              ),
            ),
          );
        });
  }

  _buildTitle() {
    return Container(
      height: 40.dh,
      width: double.infinity,
      alignment: Alignment.center,
      color: AppColors.primary,
      child: AppText('Choose Write-Off Type'.toUpperCase(),
          color: AppColors.onPrimary),
    );
  }

  _buildOptions() {
    final types = [
      WriteOffTypes.stolen,
      WriteOffTypes.damaged,
      WriteOffTypes.expired,
      WriteOffTypes.other
    ];
    return ListView.separated(
      separatorBuilder: (_, __) => const AppDivider(margin: EdgeInsets.zero),
      itemBuilder: (_, index) => _buildOption(types[index]),
      itemCount: types.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  _buildOption(WriteOffTypes type) {
    return AppTextButton(
        onPressed: () {
          pop();
          onTypeSelected(type);
        },
        isFilled: false,
        child: Container(
          height: 40.dh,
          alignment: Alignment.center,
          child: AppText(type.string),
          width: double.infinity,
        ));
  }
}
