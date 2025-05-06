import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zcvoter/src/rust/api/election.dart';

String? isSeed(String? value) {
  if (value == null || value.isEmpty) return null;

  if (!isValidSeed(seed: value)) return "Not a valid seed phrase";
  return null;
}

String? isAddress(String? value) {
  if (value == null || value.isEmpty) return null;

  if (!isValidAddress(address: value)) return "Not a valid address";
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

Future<bool> confirmDialog(BuildContext context,
    {required String title, required String message}) async {
  final confirmed = await AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        title: title,
        body: Text(message),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
        onDismissCallback: (type) {
          final res = (() {
            switch (type) {
              case DismissType.btnOk:
                return true;
              default:
                return false;
            }
          })();
          GoRouter.of(context).pop(res);
        },
        autoDismiss: false,
      ).show() ??
      false;
  return confirmed;
}

AwesomeDialog showBlockingDialog(BuildContext context, String message) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.scale,
    title: 'Please wait',
    desc: message,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    btnOk: null,
    btnCancel: null,
    showCloseIcon: false,
  )..show();
}