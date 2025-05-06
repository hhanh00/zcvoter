import 'package:flutter/material.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/store.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<StatefulWidget> createState() => ReceivePageState();
}

class ReceivePageState extends State<ReceivePage> {
  String? address;

  @override
  void initState() {
    super.initState();
    Future(() async {
      address = await getVotingAddress(hash: appStore.id!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Receive'),
        ),
        body: address != null
            ? Center(
                child: ListTile(
                  title: Text('Your Voting Address'),
                  subtitle: SelectableText(address!),
                ),
              )
            : SizedBox.shrink());
  }
}
