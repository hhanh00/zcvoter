import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:zcvoter/src/rust/api/election.dart';

import 'router.dart';
import 'src/rust/frb_generated.dart';

var logger = Logger();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RustLib.init();
  final dbDir = await getApplicationDocumentsDirectory();
  await createDirectoryDb(directory: dbDir.path);

  runApp(ToastificationWrapper(child: MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false)));
}
