import 'package:flutter/material.dart';

@immutable
class OptionItem<T> {
  const OptionItem({required this.value, required this.label});

  final T value;
  final String label;

  @override
  bool operator ==(other) {
    return other is OptionItem<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
