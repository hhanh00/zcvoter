import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:zcvoter/src/rust/api/election.dart';

String? isSeed(String? value) {
  if (value == null || value.isEmpty) return null;

  if (!isValidSeed(seed: value)) return "Not a valid seed phrase";
  return null;
}

Future<void> showException(BuildContext context, String message) async {
  await AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: 'ERROR',
    desc: message,
    btnOkOnPress: () {},
    autoDismiss: true,
  ).show();
}

Future<void> showMessage(BuildContext context, String message,
    {String? title}) async {
  await AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: title,
    desc: message,
    btnOkOnPress: () {},
    autoDismiss: true,
  ).show();
}
