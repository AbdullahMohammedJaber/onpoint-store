// ignore_for_file: non_constant_identifier_names

import 'package:ecommerce_one/route/navigation_server.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

/// 🔹 Navigate to a route normally
Future To(String routeName, {Object? arguments}) async {
  return await Navigator.of(
    NavigationService.navigatorKey.currentContext!,
  ).pushNamed(routeName, arguments: arguments);
}

/// 🔹 Open external URL

/// 🔹 Navigate with fade transition
Future ToWithFade(String routeName, {Object? arguments}) async {
  return await Navigator.of(
    NavigationService.navigatorKey.currentContext!,
  ).push(
    PageRouteBuilder(
      pageBuilder:
          (c, a1, a2) => NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
  );
}

Future<dynamic> ToWithTransition(
  String routeName, {
  required PageTransitionType type,
  Object? arguments,
}) async {
  final context = NavigationService.navigatorKey.currentContext!;

  return await Navigator.push(
    context,
    PageTransition(
      type: type,
      child: NavigationService.getPage(routeName, arguments),
      curve: Curves.easeInOutQuart,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    ),
  );
}

/// 🔹 Replace current page with new route (fade)
Future ToRemove(String routeName, {Object? arguments}) async {
  return await Navigator.of(
    NavigationService.navigatorKey.currentContext!,
  ).pushReplacement(
    PageRouteBuilder(
      pageBuilder:
          (c, a1, a2) => NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
  );
}

/// 🔹 Remove all previous routes and push new
Future ToRemoveAll(String routeName, {Object? arguments}) async {
  Navigator.pushAndRemoveUntil(
    NavigationService.navigatorKey.currentContext!,
    PageRouteBuilder(
      pageBuilder:
          (c, a1, a2) => NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
    (_) => false,
  );
}

/// 🔹 Remove all except first route
Future ToRemoveExcept(String routeName, {Object? arguments}) async {
  Navigator.pushAndRemoveUntil(
    NavigationService.navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (_) => NavigationService.getPage(routeName, arguments),
    ),
    (Route<dynamic> route) => route.isFirst,
  );
}
