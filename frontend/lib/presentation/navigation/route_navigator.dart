import 'package:flutter/material.dart';

import '../../helpers/app_messages.dart';
import '../screens/races/races_screen.dart';
import '../screens/seasons/ui/seasons_screen.dart';

class RouteNavigator {
  static const String tag = "RouteNavigator";
  static final RouteNavigator _instance = RouteNavigator._internal();

  RouteNavigator._internal() {
    navigationKey = GlobalKey<NavigatorState>();
    initialRoute = SeasonsScreen.routeName;
  }

  factory RouteNavigator() {
    return _instance;
  }

  late final GlobalKey<NavigatorState> navigationKey;

  late final String initialRoute;

  Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint("$tag -- generateRoute(RouteSettings $settings)");
    dynamic args = settings.arguments;
    switch (settings.name) {
      case SeasonsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SeasonsScreen(),
          settings: settings,
        );
      case RacesScreen.routeName:
        if (args is RacesScreenAttributes) {
          return MaterialPageRoute(
            builder: (context) => RacesScreen(attributes: args),
            settings: settings,
          );
        }
        return _errorRoute();
      default:
        debugPrint("$tag -- Invalid route: ${settings.name}");
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(AppMessages.error)),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppMessages.notFound,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  AppMessages.destinationNotFound,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
