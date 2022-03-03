import '../source.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.nextPage}) : super(key: key);

  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => push(nextPage),
      child: const Icon(Icons.add, color: AppColors.onPrimary),
    );
  }
}
