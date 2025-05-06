import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/main.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/store.dart';
import 'package:zcvoter/utils.dart';

class VotePage extends StatefulWidget {
  final int? initialChoice;
  const VotePage({this.initialChoice, super.key});

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
    Future(appStore.updateVoteHistory);
  }

  @override
  Widget build(BuildContext context) {
    final options = appStore.election!.answers
        .asMap()
        .entries
        .map((a) =>
            FormBuilderFieldOption(value: a.key, child: Text(a.value.value)))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Vote"),
      ),
      body: Observer(builder: (context) {
        appStore.availableVotes;
        appStore.votes;

        final votes = appStore.votes.where((v) => v.choice != null).toList();
        logger.i("Votes: ${votes.length}");

        return CustomScrollView(
          slivers: [
            PinnedHeaderSliver(
              child: FormBuilder(
                key: formKey,
                child: Padding(
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
                      FormBuilderRadioGroup<int>(
                        name: "choice",
                        orientation: OptionsOrientation.vertical,
                        options: options,
                        validator: FormBuilderValidators.required(),
                        initialValue: widget.initialChoice,
                      ),
                      Gap(16),
                      OverflowBar(children: [
                        IconButton.filled(
                            tooltip: "Vote",
                            onPressed: onVote,
                            icon: Icon(Icons.how_to_vote))
                      ]),
                      Gap(16),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
            SliverList.builder(
                itemBuilder: (context, index) {
                  final vote = votes[index];
                  return ListTile(
                    title: Text(appStore.election!.answers[vote.choice!].value),
                    trailing: Text(
                        (vote.amount ~/ BigInt.from(ZatsPerVote)).toString()),
                  );
                },
                itemCount: votes.length),
          ],
        );
      }),
    );
  }

  void onVote() async {
    final form = formKey.currentState!;
    if (!form.saveAndValidate()) return;

    final voteString = form.value["vote"] as String;
    final vote = int.parse(voteString);
    final choice = form.value["choice"] as int;
    final answer = appStore.election!.answers[choice].value;
    logger.i("Vote: $vote for $choice");
    final confirmed = await confirmDialog(context, title: "Vote",
        message: "Are you sure you want to give $vote votes to '$answer'?");
    if (!confirmed) return;

    if (!mounted) return;
    final wait = showBlockingDialog(context, "Submitting vote...");
    final voteHash = await voteElection(
        hash: appStore.id!,
        address: appStore.election!.answers[choice].address,
        amount: BigInt.from(vote * ZatsPerVote),
        choice: choice);
    logger.i("Vote hash: $voteHash");
    wait.dismiss();

    if (!mounted) return;
    await showMessage(context, title: "Vote submitted", "Vote hash: $voteHash");
    if (!mounted) return;
    GoRouter.of(context).pop();
  }
}
