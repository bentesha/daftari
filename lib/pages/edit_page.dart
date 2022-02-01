import '../source.dart';

class EditPage extends StatelessWidget {
  const EditPage({
    Key? key,
    required this.pageTitle,
    required this.titlesList,
  }) : super(key: key);

  final String pageTitle;
  final List<String> titlesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  _buildBody() {
    return ListView(
      children: [
        _buildTitle(),
        AppTextField(
            errors: const {},
            text: '',
            onChanged: (_) {},
            hintText: '',
            keyboardType: TextInputType.text,
            label: titlesList[0],
            errorName: ''),
        AppTextField(
            errors: const {},
            text: '',
            onChanged: (_) {},
            hintText: '',
            keyboardType: TextInputType.text,
            label: titlesList[1],
            errorName: ''),
        AppTextField(
            errors: const {},
            text: '',
            onChanged: (_) {},
            hintText: '',
            keyboardType: TextInputType.text,
            label: titlesList[2],
            errorName: ''),
        AppTextField(
            errors: const {},
            text: '',
            onChanged: (_) {},
            hintText: '',
            keyboardType: TextInputType.text,
            label: titlesList[3],
            errorName: ''),
      ],
    );
  }

  _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: AppText(pageTitle, style: AppTextStyles.heading2),
    );
  }

  _buildBottomNavBar() {
    return Builder(builder: (context) {
      return AppTextButton(
        onPressed: () => Navigator.pop(context),
        height: 40.dh,
        margin: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 19.dw),
        text: 'Done',
        textStyle: AppTextStyles.body2.copyWith(color: AppColors.onPrimary),
      );
    });
  }
}
