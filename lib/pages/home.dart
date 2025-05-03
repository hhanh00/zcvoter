import 'package:flutter/material.dart';
import 'package:zcvoter/src/rust/api/election.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<ElectionRec> elections = [];

  @override
  void initState() {
    super.initState();
    Future(() async {
      final elections = await listElections();
      setState(() => this.elections = elections);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddElection)
        ],
      ),
      body: ListView.builder(
        itemCount: elections.length,
        itemBuilder: (context, index) {
          final election = elections[index];
          return ListTile(
            title: Text(election.name),
            subtitle: Text(election.question),
          );
        },
      ),
    );
  }

  void onAddElection() async {}
}