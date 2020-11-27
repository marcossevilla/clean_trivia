import 'package:flutter/material.dart';

import '../number_trivia/presentation/pages/number_trivia_page.dart';

class CleanTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Trivia App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: NumberTriviaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
