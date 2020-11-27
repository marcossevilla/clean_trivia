import 'package:flutter/material.dart';

import 'displayed_content.dart';

class LoadingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DisplayedContent(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
