import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/scanner.dart';
import 'package:zcvoter/src/rust/api/election.dart';
import 'package:zcvoter/utils.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final urlController = TextEditingController();
  final lwdController = TextEditingController(text: "https://zec.rocks");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Election'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                      child: FormBuilderTextField(
                    name: "url",
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: "Election URL",
                      hintText: "http://example.com/election/0000000...",
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.url(),
                    ]),
                  )),
                  IconButton(
                      tooltip: "Scan Election QR Code",
                      icon: const Icon(Icons.qr_code),
                      onPressed: onScan)
                ]),
                FormBuilderTextField(
                  name: "lwd",
                  controller: lwdController,
                  decoration: const InputDecoration(labelText: "Lightwallet URL"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.url(),
                  ]),
                ),
                FormBuilderTextField(
                  name: "seed",
                  decoration: const InputDecoration(labelText: "Wallet Seed"),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    isSeed,
                  ]),
                ),
                Gap(32),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add Election'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onScan() async {
    final code = await showScanner(context, validator: isSeed);
    if (code != null) {
      urlController.text = code;
    }
  }

  onAdd() async {
    final form = formKey.currentState!;
    if (!form.saveAndValidate()) {
      return;
    }

    try {
      final url = urlController.text;
      final lwd = lwdController.text;
      final seed = form.fields["seed"]?.value!;
      await connectElection(url: url, lwd: lwd, seed: seed);
      if (!mounted) return;
      GoRouter.of(context).pop();
    } on AnyhowException catch (e) {
      await showException(context, e.message);
    }
  }
}
