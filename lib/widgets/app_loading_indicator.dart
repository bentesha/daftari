import '../source.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({this.isUsingScaffold = false, Key? key})
      : super(key: key);

  final bool isUsingScaffold;

  const AppLoadingIndicator.withScaffold({Key? key})
      : isUsingScaffold = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isUsingScaffold ? const Scaffold(body: _child) : _child;
  }

  static const _child = Center(child: CircularProgressIndicator());
}
