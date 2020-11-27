import 'package:flutter/material.dart';

import 'package:number_trivia/number_trivia.dart';

import 'displayed_content.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({Key key, this.trivia}) : super(key: key);

  final NumberTriviaModel trivia;

  @override
  Widget build(BuildContext context) {
    return DisplayedContent(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${trivia.number}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  trivia.text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
