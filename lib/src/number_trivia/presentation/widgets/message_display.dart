import 'package:flutter/material.dart';

import 'displayed_content.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({Key key, @required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return DisplayedContent(
      child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
