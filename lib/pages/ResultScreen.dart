import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/pages/HomeScreen.dart';
import 'package:quiz_app/util/state/questionState.dart';

import 'QuizScreen.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(20)),
            height: 150,
            child: Center(child: Text("You Scored : $score")),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(),
                    ));
                ref.invalidate(questionProvider);
                ref.invalidate(correctQuestionProivder);
                ref
                    .read(questionProvider.notifier)
                    .getQuestionFinal(ref.read(category), ref.read(level));
              },
              child: Text("Restart")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(questionProvider.notifier).resetQuiz();
                ref.invalidate(correctQuestionProivder);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text("Exit")),
        ]),
      ),
    );
  }
}
