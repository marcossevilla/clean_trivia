import 'package:flutter/material.dart';

import 'locator.dart' as di;
import 'src/core/app.dart';

void main() async {
  await di.init();
  runApp(CleanTriviaApp());
}
