import 'package:flutter/material.dart';
import 'package:inventory_management/source.dart';

class ScreenSizeConfig {
  static Size _designSize = const Size(0, 0);
  static Size _screenSize = const Size(0, 0);

  static void init(Size designSize, Size screenSize) {
    _designSize = designSize;
    _screenSize = screenSize;
  }

  //s for screen
  //d for design
  static final sWidth = _screenSize.width;
  static final dWidth = _designSize.width;
  static final sHeight = _screenSize.height;
  static final dHeight = _designSize.height;

  static double get getFullWidth => _screenSize.width;
  static double get getFullHeight => _screenSize.height;

  static double getProportionalWidth(num width) => ((width * sWidth) / dWidth);
  static double getProportionalHeight(num height) => ((height * sHeight) / dHeight);
}

extension SizeExtension on num {
  // ignore: unused_element
  double get dw => ScreenSizeConfig.getProportionalWidth(this);
  double get dh => ScreenSizeConfig.getProportionalHeight(this);
}
