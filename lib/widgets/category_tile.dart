import '../source.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, required this.title, required this.numberOfItems})
      : super(key: key);

  final String title;
  final int numberOfItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.dw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title, weight: FontWeight.w500),
              SizedBox(height: 5.dh),
              AppText('$numberOfItems items', opacity: .75)
            ],
          ),
          AppIconButton(
            icon: Icons.chevron_right,
            iconColor: AppColors.secondary.withOpacity(.85),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
