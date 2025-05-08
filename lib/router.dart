import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/pages/add.dart';
import 'package:zcvoter/pages/build.dart';
import 'package:zcvoter/pages/delegate.dart';
import 'package:zcvoter/pages/election.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/pages/receive.dart';
import 'package:zcvoter/pages/vote.dart';
import 'package:zcvoter/scanner.dart';
import 'package:zcvoter/src/rust/api/election.dart';

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
        path: '/build-election', builder: (context, state) => const BuildPage()),
    GoRoute(
        path: '/add-election', builder: (context, state) => const AddPage()),
    GoRoute(
        path: '/election', builder: (context, state) => ElectionPage(election: state.extra as ElectionRec)),
    GoRoute(
        path: '/receive', builder: (context, state) => ReceivePage()),
    GoRoute(
        path: '/vote', builder: (context, state) => VotePage(initialChoice: state.extra as int?)),
    GoRoute(
        path: '/delegate', builder: (context, state) => DelegatePage()),
    GoRoute(
        path: '/scanner',
        builder: (context, state) =>
            ScannerPage(validator: state.extra as String? Function(String?))),
  ],
);
