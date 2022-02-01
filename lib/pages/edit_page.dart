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
        ListView.builder(
            itemCount: titlesList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => AppTextField(
                errors: const {},
                text: '',
                onChanged: (_) {},
                hintText: '',
                keyboardType: TextInputType.text,
                label: titlesList[index],
                errorName: '')),
      ],
    );
  }

  _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.dw, vertical: 10.dh),
      child: AppText(pageTitle, size: 24.dw, weight: FontWeight.bold),
    );
  }

  _buildBottomNavBar() {
    return Builder(builder: (context) {
      return AppTextButton(
        onPressed: () => Navigator.pop(context),
        height: 50.dh,
        margin: EdgeInsets.only(left: 19.dw, right: 19.dw, bottom: 10.dw),
        text: 'Done',
      );
    });
  }
}
