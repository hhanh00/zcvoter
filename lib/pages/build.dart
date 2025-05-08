import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/utils.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  State<BuildPage> createState() => BuildPageState();
}

class BuildPageState extends State<BuildPage> {
  int? minHeight;
  Observable<int?> height = Observable(null);
  Observable<String> message = Observable("");

  @override
  void initState() {
    super.initState();
    Future(() async {
      minHeight = await getOrchardHeight();
    });
  }

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Build Election"),
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "name",
                    decoration:
                        const InputDecoration(labelText: "Election Name"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Gap(16),
                  FormBuilderTextField(
                    name: "lwd",
                    decoration: const InputDecoration(
                        labelText: "Lightwalletd server URL"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    initialValue: "https://zec.rocks",
                  ),
                  Gap(16),
                  Row(children: [
                    Expanded(
                        child: FormBuilderTextField(
                      name: "start_registration",
                      decoration: const InputDecoration(
                          labelText: "Start Registration Height"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        if (minHeight != null)
                          FormBuilderValidators.min(minHeight!),
                        validateRange,
                      ]),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                    Gap(16),
                    Expanded(
                        child: FormBuilderTextField(
                      name: "end_registration",
                      decoration: const InputDecoration(
                          labelText: "End Registration Height"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        if (minHeight != null)
                          FormBuilderValidators.min(minHeight!),
                      ]),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    )),
                  ]),
                  Gap(16),
                  FormBuilderTextField(
                    name: "question",
                    decoration: const InputDecoration(labelText: "Question"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Gap(16),
                  FormBuilderTextField(
                    name: "answers",
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        labelText: "Choices (one per line)"),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  Gap(32),
                  ElevatedButton(
                    onPressed: onCreate,
                    child: const Text("Create Election"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void onCreate() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final name = formKey.currentState?.fields['name']?.value as String;
      final lwd = formKey.currentState?.fields['lwd']?.value as String;
      final start =
          formKey.currentState?.fields['start_registration']?.value as String;
      final end =
          formKey.currentState?.fields['end_registration']?.value as String;
      final question =
          formKey.currentState?.fields['question']?.value as String;
      final answers = formKey.currentState?.fields['answers']?.value as String;

      final startHeight = int.parse(start);
      final endHeight = int.parse(end);

      Future<CreateElectionResult_Result> run() async {
        final complete = Completer<CreateElectionResult_Result>();
        try {
          final progress = createElection(
              name: name,
              start: startHeight,
              end: endHeight,
              question: question,
              answers: answers,
              lwd: lwd);
          progress.listen((h) {
            if (h is CreateElectionResult_Progress) {
              final currentHeight = h.height;
              runInAction(() => height.value = currentHeight);
            } else if (h is CreateElectionResult_Message) {
              final m = h.message;
              runInAction(() => message.value = m);
            } else if (h is CreateElectionResult_Result) {
              complete.complete(h);
            }
          }, onError: (e) {
            complete.completeError(e);
          });
        } on AnyhowException catch (e) {
          complete.completeError(e);
        }
        return complete.future;
      }

      AwesomeDialog? dialog;
      try {
        dialog = AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Please wait',
          body: Observer(builder: (context) {
            message.value;
            final h = height.value;
            final progress = h != null
                ? ((h - startHeight) / (endHeight - startHeight))
                    .clamp(0.0, 1.0)
                : null;

            return Column(
              children: [
                const Text("Building election... Please wait"),
                Gap(16),
                if (message.value.isNotEmpty)
                  Text(message.value, style: const TextStyle(color: Colors.blue)),
                Gap(16),
                SizedBox(
                    height: 8, child: LinearProgressIndicator(value: progress)),
                Gap(16),
              ],
            );
          }),
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          btnOk: null,
          btnCancel: null,
          showCloseIcon: false,
        );
        unawaited(dialog.show());
        final r = await run();
        final hash = r.hash;
        final phrase = r.phrase;
        final electionString = r.electionString;

        if (!mounted) return;
        final t = Theme.of(context).textTheme;
        dialog.dismiss();
        dialog = AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.scale,
          title: 'Election Created',
          body: Column(children: [
            Text("Election Seed Phrase", style: t.headlineSmall),
            Text("It is important to keep it safe and secret"),
            Text("It is required to decrypt the election results"),
            Text("Make sure to keep it safe"),
            Text("It is not stored anywhere"),
            Text("It is not possible to recover it"),
            Gap(16),
            SelectableText(phrase, style: t.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          ]),
          btnOk: ElevatedButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: const Text("Save Election"),
          ));
        await dialog.show();
        await FilePicker.platform.saveFile(
          dialogTitle: "Election Data File",
          fileName: "$hash.json",
          bytes: utf8.encode(electionString));
      } on AnyhowException catch (e) {
        if (mounted) await showException(context, e.message);
      } finally {
        if (mounted) dialog?.dismiss();
      }
    }
  }

  String? validateRange(String? start) {
    if (start == null || start.isEmpty) {
      return null;
    }
    final end =
        formKey.currentState?.fields['end_registration']?.value as String?;
    if (end == null || end.isEmpty) {
      return null;
    }

    final s = int.tryParse(start);
    final e = int.tryParse(end);

    if (s == null || e == null) {
      return "Not a number";
    }
    if (s > e) {
      return "Start height must be less than end height";
    }

    return null;
  }
}
