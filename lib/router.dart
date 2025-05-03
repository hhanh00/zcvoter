import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/pages/home.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  initialLocation: '/',
  observers: [routeObserver],
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
  ],
);
