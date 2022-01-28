import '../source.dart';

class ScreenSizeInit extends StatelessWidget {
  const ScreenSizeInit({required this.child, required this.designSize, key})
      : super(key: key);

  final Size designSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 0) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        ScreenSizeConfig.init(designSize, Size(screenWidth, screenHeight));
        return child;
      }
      return Container();
    });
  }
}
