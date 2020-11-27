import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../locator.dart';
import '../bloc/numbertrivia_bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  /// Static named route for page
  static const String route = 'NumberTrivia';

  /// Static method to return the widget as a PageRoute
  static Route go() {
    return MaterialPageRoute<void>(builder: (_) => NumberTriviaPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Trivia'),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider<NumberTriviaBloc>(
        create: (_) => locator<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _NumberTrivia(),
                const SizedBox(height: 20),
                const _TriviaForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TriviaForm extends StatefulWidget {
  const _TriviaForm({Key key}) : super(key: key);

  @override
  __TriviaFormState createState() => __TriviaFormState();
}

class __TriviaFormState extends State<_TriviaForm> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _inputController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => addSpecific(),
          decoration: const InputDecoration(
            filled: true,
            hintText: 'Input a number',
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                child: const Text('Random'),
                onPressed: addRandom,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: RaisedButton(
                child: const Text('Search'),
                onPressed: addSpecific,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void addSpecific() {
    context
        .read<NumberTriviaBloc>()
        .add(GetTriviaForSpecificNumber(_inputController.text));
    _inputController.clear();
  }

  void addRandom() {
    _inputController.clear();
    context.read<NumberTriviaBloc>().add(GetTriviaForRandomNumber());
  }
}

class _NumberTrivia extends StatelessWidget {
  const _NumberTrivia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Empty) {
          return const MessageDisplay(message: 'Start searching...');
        } else if (state is Error) {
          return MessageDisplay(message: state.message);
        } else if (state is Loading) {
          return LoadingContent();
        } else if (state is Loaded) {
          return TriviaDisplay(trivia: state.trivia);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
