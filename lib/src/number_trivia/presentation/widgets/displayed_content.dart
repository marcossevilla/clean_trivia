import 'package:flutter/material.dart';

class DisplayedContent extends StatelessWidget {
  const DisplayedContent({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(child: child),
    );
  }
}
