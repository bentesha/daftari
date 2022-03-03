import 'package:inventory_management/source.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void push(Widget page) async => await navigatorKey.currentState
    ?.push(MaterialPageRoute(builder: (_) => page));

void pop() => navigatorKey.currentState?.pop();
