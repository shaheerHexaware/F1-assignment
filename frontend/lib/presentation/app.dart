import 'package:f1_app/data/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/app_messages.dart';
import 'navigation/app_nav_observer.dart';
import 'navigation/route_navigator.dart';

class App extends StatefulWidget {
  final RouteNavigator navigator;

  const App({super.key, required this.navigator});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepository(),
      child: MaterialApp(
        title: AppMessages.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        navigatorKey: widget.navigator.navigationKey,
        initialRoute: widget.navigator.initialRoute,
        onGenerateRoute: widget.navigator.generateRoute,
        navigatorObservers: [AppNavObserver.instance],
      ),
    );
  }
}
