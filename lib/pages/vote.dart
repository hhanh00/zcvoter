import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:zcvoter/main.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/store.dart';

class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => VotePageState();
}

class VotePageState extends State<VotePage> {
  final formKey = GlobalKey<FormBuilderState>();
  final voteController = TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
    Future(appStore.updateAvailableVotes);
  }

  @override
  Widget build(BuildContext context) {
    final options = appStore.election!.answers
        .map((a) =>
            FormBuilderFieldOption(value: a.address, child: Text(a.value)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Vote"),
      ),
      body: CustomScrollView(
        slivers: [
          PinnedHeaderSliver(
            child: FormBuilder(
              key: formKey,
              child: Observer(
                builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text("Available Votes"),
                            subtitle: Text(
                                "You have ${appStore.availableVotes} votes available")),
                        FormBuilderTextField(
                          name: "vote",
                          decoration: InputDecoration(labelText: "Votes"),
                          controller: voteController,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.integer(),
                            FormBuilderValidators.min(1),
                            FormBuilderValidators.max(appStore.availableVotes),
                          ]),
                        ),
                        Gap(8),
                        FormBuilderRadioGroup<String>(
                            name: "choice",
                            orientation: OptionsOrientation.vertical,
                            options: options,
                            validator: FormBuilderValidators.required(),
                            ),
                        Gap(16),
                        OverflowBar(children: [
                          IconButton.filled(
                              tooltip: "Vote",
                              onPressed: onVote,
                              icon: Icon(Icons.how_to_vote))
                        ])
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onVote() async {
    final form = formKey.currentState!;
    if (!form.saveAndValidate()) return;

    final voteString = form.value["vote"] as String;
    final vote = int.parse(voteString);
    final choice = form.value["choice"] as String;
    logger.i("Vote: $vote for $choice");

    await voteElection(
        hash: appStore.id!,
        address: choice,
        amount: BigInt.from(vote * ZatsPerVote));
  }
}
