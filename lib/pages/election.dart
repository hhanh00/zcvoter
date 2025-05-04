import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    final election = appStore.election;
    if (election == null) {
      return const Center(child: Text("No election data available"));
    }

    return Scaffold(appBar: AppBar(title: Text(election.name)));
  }
}
