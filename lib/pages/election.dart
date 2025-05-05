import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:zcvoter/store.dart';

class ElectionPage extends StatelessWidget {
  final String id;
  const ElectionPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: appStore.loadElectionData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return ElectionContent(id: id);
          }
        },
      );
}

class ElectionContent extends StatefulWidget {
  final String id;
  const ElectionContent({required this.id, super.key});

  @override
  State<ElectionContent> createState() => ElectionContentState();
}

class ElectionContentState extends State<ElectionContent> {
  @override
  void initState() {
    super.initState();
    Future(appStore.startAutoSync);
  }

  @override
  void dispose() {
    Future(appStore.cancelAutoSync);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final election = appStore.election;
    if (election == null) {
      return const Center(child: Text("No election data available"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(election.name),
          actions: [
            IconButton(
                tooltip: "Delegate",
                icon: const Icon(Icons.forward),
                onPressed: () {}),
            IconButton(
                tooltip: "Vote",
                icon: const Icon(Icons.how_to_vote),
                onPressed: () {}),
          ],
        ),
        body: Observer(builder: (context) {
          final height = appStore.height;
          final progress = height != null
              ? ((height - election.startHeight) /
                      (election.endHeight - election.startHeight))
                  .clamp(0.0, 1.0)
              : null;
          return SingleChildScrollView(
              child: Column(
            children: [
              ListTile(
                title: Text("Election ID"),
                subtitle: Text(widget.id),
              ),
              ListTile(
                title: Text("Registration Range"),
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
                    )),
                if (height != null) ...[
                  Gap(16),
                  ListTile(
                    title: Text(election.name),
                    subtitle: LinearProgressIndicator(value: progress!),
                  ),
                  Gap(8),
                  Text(
                      "Please hold on while the election data is retrieved and processed."),
                ],
              ]))
            ],
          ));
        }));
  }
}
