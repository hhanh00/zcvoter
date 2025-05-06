import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/store.dart';

class ElectionPage extends StatefulWidget {
  final ElectionRec election;
  const ElectionPage({super.key, required this.election});

  @override
  State<ElectionPage> createState() => ElectionPageState();
}

class ElectionPageState extends State<ElectionPage> {
  @override
  void initState() {
    super.initState();
    Future(() async {
      await appStore.loadElectionData(widget.election.hash);
      await appStore.updateAvailableVotes();
      await appStore.updateVoteHistory();
      await appStore.startAutoSync();
    });
  }

  @override
  void dispose() {
    Future(appStore.cancelAutoSync);
    appStore.election = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.election.name),
          actions: [
            IconButton(
                tooltip: "Receive",
                icon: const Icon(Icons.inbox),
                onPressed: onReceive),
            IconButton(
                tooltip: "Delegate",
                icon: const Icon(Icons.forward),
                onPressed: onDelegate),
            IconButton(
                tooltip: "Vote",
                icon: const Icon(Icons.how_to_vote),
                onPressed: () => GoRouter.of(context).push("/vote")),
          ],
        ),
        body: Observer(builder: (context) {
          final refDataLoaded = appStore.refDataLoaded;
          final election = appStore.election;
          if (election == null) {
            return const Center(child: Text("No election data available"));
          }
          final height = appStore.height;
          final progress = height != null
              ? ((height - election.startHeight) /
                      (election.endHeight - election.startHeight))
                  .clamp(0.0, 1.0)
              : null;
          return SingleChildScrollView(
              child: Column(children: [
            if (refDataLoaded) ...[
              ListTile(
                title: Tooltip(message: "Check that it matches the value published by the organizer", child: Text("Election ID")),
                subtitle: Text(widget.election.hash),
              ),
              ListTile(
                title: Tooltip(message: "The block range when notes are considered eligible", child: Text("Registration Range")),
                subtitle: Text(
                    "From ${election.startHeight} to ${election.endHeight}"),
              ),
              Gap(16),
              Card(
                  margin: const EdgeInsets.all(16),
                  elevation: 4,
                  child: Column(children: [
                    ListTile(
                      title: Text("Question"),
                      subtitle: Text(election.question, style: t.headlineSmall),
                    ),
                    ...election.answers.asMap().entries.map((a) => ListTile(
                          leading: CircleAvatar(child: Text("${a.key + 1}")),
                          title: Text(a.value.value),
                          onTap: () => GoRouter.of(context).push("/vote", extra: a.key),
                        )),
                  ]))
            ],
            if (height != null) ...[
              Gap(16),
              ListTile(
                title: Text("Download Progress"),
                subtitle: LinearProgressIndicator(value: progress!),
              ),
              Gap(8),
              Text(
                  "Please hold on while the election data is retrieved and processed."),
            ],
          ]));
        }));
  }

  onReceive() {
    GoRouter.of(context).push("/receive");
  }

  onDelegate() {
    GoRouter.of(context).push("/delegate");
  }
}
