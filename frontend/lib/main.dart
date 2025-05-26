import 'package:flutter/material.dart';

import 'presentation/app.dart';
import 'presentation/navigation/route_navigator.dart';

void main() {
  final navigator = RouteNavigator();

  runApp(App(navigator: navigator));
}
