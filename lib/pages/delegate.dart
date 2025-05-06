import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:zcvoter/pages/home.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/store.dart';
import 'package:zcvoter/utils.dart';

class DelegatePage extends StatefulWidget {
  const DelegatePage({super.key});

  @override
  State<StatefulWidget> createState() => DelegatePageState();
}

class DelegatePageState extends State<DelegatePage> {
  final formKey = GlobalKey<FormBuilderState>();
  final voteController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delegate"),
        ),
        body: Observer(builder: (context) {
          final votes = appStore.votes.where((v) => v.choice == null).toList();
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
                        FormBuilderTextField(
                          name: "address",
                          decoration: InputDecoration(
                              labelText: "Recipient Voting Address"),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            isAddress,
                          ]),
                        ),
                        Gap(16),
                        OverflowBar(children: [
                          IconButton.filled(
                              tooltip: "Vote",
                              onPressed: onDelegate,
                              icon: Icon(Icons.forward))
                        ]),
                        Gap(16),
                        Divider()
                      ],
                    ),
                  ),
                ),
              ),
              SliverList.builder(
                  itemCount: votes.length,
                  itemBuilder: (context, index) {
                    final vote = votes[index];
                    return ListTile(
                        title: Text(vote.address),
                        trailing: Text((vote.amount ~/ BigInt.from(ZatsPerVote))
                            .toString()));
                  }),
            ],
          );
        }));
  }

  void onDelegate() async {
    if (!formKey.currentState!.saveAndValidate()) return;
    final vote = int.parse(voteController.text);
    final address = formKey.currentState!.fields["address"]!.value;
    final voteHash = await voteElection(
        hash: appStore.id!,
        address: address,
        amount: BigInt.from(vote * ZatsPerVote));
    if (!mounted) return;
    await showMessage(context, title: "Delegation submitted", "Delegation hash: $voteHash");
    if (!mounted) return;
    GoRouter.of(context).pop();
  }
}
