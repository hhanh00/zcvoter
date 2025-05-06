import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/utils.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key}) : super(key: key);

  @override
  State<BuildPage> createState() => BuildPageState();
}

class BuildPageState extends State<BuildPage> {
  int? minHeight;
  int? height;

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
                    decoration:
                        const InputDecoration(labelText: "Lightwalletd server URL"),
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

      Future<void> run() async {
        final complete = Completer();
        try {
          final progress = createElection(
              name: name,
              start: int.parse(start),
              end: int.parse(end),
              question: question,
              answers: answers.split("\n"),
              lwd: lwd);
          progress.listen((h) {
            print(h);
            setState(() => height = h);
          },
              onDone: () => complete.complete(),
              onError: (e) => complete.completeError(e));
        } on AnyhowException catch (e) {
          complete.completeError(e);
        }
        return complete.future;
      }

      AwesomeDialog? dialog;
      try {
        dialog = showBlockingDialog(context, "Please wait while we build the election");
        await run();
      }
      on AnyhowException catch (e) {
        if (mounted)
          await showException(context, e.message);
      }
      finally {
        if (mounted)
          dialog?.dismiss();
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
