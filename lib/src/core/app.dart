import 'package:flutter/material.dart';

import '../number_trivia/presentation/views/home_page.dart';

class CleanTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Trivia App',
      home: HomePage(),
    );
  }
}
