import 'package:f1_app/presentation/data_repository_provider.dart';
import 'package:flutter/material.dart';

import '../helpers/app_messages.dart';
import 'navigation/app_nav_observer.dart';
import 'navigation/route_navigator.dart';

const seedColor = Color(0xffff1801);

class App extends StatefulWidget {
  final RouteNavigator navigator;

  const App({super.key, required this.navigator});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DataRepositoryProvider(
      child: MaterialApp(
        title: AppMessages.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system, // This will follow the system theme
        navigatorKey: widget.navigator.navigationKey,
        initialRoute: widget.navigator.initialRoute,
        onGenerateRoute: widget.navigator.generateRoute,
        navigatorObservers: [AppNavObserver.instance],
      ),
    );
  }
}
