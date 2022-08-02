import '../source.dart';

class ItemsListTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  const ItemsListTitle(
      {Key? key,
      required this.enabled,
      required this.title,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
      child: Row(
        mainAxisAlignment:
            enabled ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          if (enabled)
            TextButton.icon(
                onPressed: onPressed,
                style: TextButton.styleFrom(backgroundColor: AppColors.primary),
                icon: const Icon(Icons.add, color: AppColors.onPrimary),
                label: const Text("New Item",
                    style: TextStyle(color: AppColors.onPrimary)))
          /* AppTextButton(
              onPressed: onPressed,
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5),
              child: Row(
                children: const [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text("New Item", style: TextStyle(color: AppColors.onPrimary))
                ],
              )), */
        ],
      ),
    );
  }
}
