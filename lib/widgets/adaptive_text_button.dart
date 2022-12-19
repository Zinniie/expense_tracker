import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  // const AdaptiveFlatButton({super.key});
  String? text;
  VoidCallback? handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            // color: Colors.blue,
            child: Text(
              text.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: handler)
        : TextButton(
            onPressed: handler,
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor, // foreground
            ),
            child: Text(
              text.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
