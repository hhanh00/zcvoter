import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/pages/add.dart';
import 'package:zcvoter/pages/election.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/scanner.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  initialLocation: '/',
  observers: [routeObserver],
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
        path: '/add-election', builder: (context, state) => const AddPage()),
    GoRoute(
        path: '/election', builder: (context, state) => ElectionPage(id: state.extra as String)),
    GoRoute(
        path: '/scanner',
        builder: (context, state) =>
            ScannerPage(validator: state.extra as String? Function(String?))),
  ],
);
