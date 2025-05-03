import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zcvoter/src/rust/api/election.dart';

import 'router.dart';
import 'src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RustLib.init();
  final dbDir = await getApplicationDocumentsDirectory();
  await createDirectoryDb(directory: dbDir.path);

  await connectElection(url: "http://zebra2.zcash-infra.com:8000/election/f25446783de9082fa00cb5754a129fedb7f1d61ec6c144252f48077ac641e822");

  runApp(MaterialApp.router(
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false));
}
