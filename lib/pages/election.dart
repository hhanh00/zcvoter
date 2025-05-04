import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
            return ElectionContent();
          }
        },
      );
}

class ElectionContent extends StatefulWidget {
  const ElectionContent({super.key});

  @override
  State<ElectionContent> createState() => ElectionContentState();
}

class ElectionContentState extends State<ElectionContent> {
  @override
  void initState() {
    super.initState();
    Future(appStore.synchronize);
  }

  @override
  Widget build(BuildContext context) {
    final election = appStore.election;
    if (election == null) {
      return const Center(child: Text("No election data available"));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(election.name),
        ),
        body: Observer(builder: (context) {
          final height = appStore.height;
          final progress = height != null
              ? ((height - election.startHeight) / (election.endHeight - election.startHeight)).clamp(0.0, 1.0)
              : null;
          return Column(
            children: [
              if (height != null)
                ListTile(
                  title: Text(election.name),
                  subtitle: LinearProgressIndicator(value: progress!),
                ),
            ],
          );
        }));
  }
}
