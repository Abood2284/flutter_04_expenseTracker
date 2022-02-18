import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  AdaptiveFlatButton({
    required this.text,
    required this.handler,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(text),
          )

        /// * That will take all the width available after giving our Text Widget the space it needs
        : Expanded(
            child: TextButton(
              onPressed: handler,
              child: Text(text),
            ),
          );
  }
}
