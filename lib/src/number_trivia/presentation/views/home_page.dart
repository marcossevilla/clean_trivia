import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String route = 'Home';

  static Route go() => MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Trivia')),
      body: const Center(child: Text('Welcome to Clean Trivia')),
    );
  }
}
