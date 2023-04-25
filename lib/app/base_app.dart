import 'package:flutter/material.dart';

import 'micro_core_utils.dart';
import 'microapp.dart';

abstract class BaseApp {
  List<Microapp> get microApps;

  Map<String, WidgetBuilderArgs> get baseRouters;

  final Map<String, WidgetBuilderArgs> routers = {};

  void registerRouters() {
    if (baseRouters.isNotEmpty ?? false) routers.addAll(baseRouters);
    if (microApps.isNotEmpty ?? false) {
      for (Microapp microapp in microApps) {
        routers.addAll(microapp.routers);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    var routerName = settings.name;
    Object routerArgs = settings.arguments ?? {};

    var navigateTo = routers[routerName];
    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }
}
