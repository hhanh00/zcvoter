import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:zcvoter/router.dart';
import 'package:zcvoter/src/rust/api/election.dart';

const ZatsPerVote = 100000;

final addElectionID = GlobalKey();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with RouteAware {
  List<ElectionRec> elections = [];

  @override
  void initState() {
    super.initState();
    Future(_refresh);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    Future(_refresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections'),
        actions: [
          Showcase(key: addElectionID, description: "Tap to Start a new Election", child:
          IconButton(icon: const Icon(Icons.add), onPressed: onAddElection))
        ],
      ),
      body: ListView.builder(
        itemCount: elections.length,
        itemBuilder: (context, index) {
          final election = elections[index];
          return ListTile(
            title: Text(election.name),
            subtitle: Text(election.question),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                GoRouter.of(context).push("/election", extra: election),
          );
        },
      ),
    );
  }

  void onAddElection() async {
    await GoRouter.of(context).push('/add-election');
  }

  _refresh() async {
    final elections = await listElections();
    if (elections.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([
          addElectionID,
        ]);
      });
    }
    setState(() => this.elections = elections);
  }
}
