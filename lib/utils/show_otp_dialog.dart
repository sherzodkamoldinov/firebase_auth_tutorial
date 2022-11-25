import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    // user can't close dialog when press without dialog area
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Enter OTP'),
      content: Column(
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: onPressed, child: const Text('Done'))
      ],
    ),
  );
}
