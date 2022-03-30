import '../source.dart';

class ScreenSizeInit extends StatelessWidget {
  const ScreenSizeInit({required this.child, required this.designSize, key})
      : super(key: key);

  final Size designSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        final isPortrait = orientation == Orientation.portrait;

        if (constraints.maxWidth > 0) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final screenSize = isPortrait
              ? Size(screenWidth, screenHeight)
              : Size(screenHeight, screenWidth);
          ScreenSizeConfig.init(designSize, screenSize);
          return child;
        }
        return Container();
      });
    });
  }
}
