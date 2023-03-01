import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/pages/HomeScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/state/questionState.dart';

import 'QuizScreen.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int wrong = 10 - score;
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("GAME OVER"),
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
                try {
                  ref.read(authRepositoryProvider).updateData(wrong, score);
                } on Exception catch (e) {
                  print("error");
                }
                Navigator.pushNamed(context, quizPage);
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
                try {
                  ref.read(authRepositoryProvider).updateData(wrong, score);
                } on Exception catch (e) {
                  print("error");
                }
                ref.read(questionProvider.notifier).resetQuiz();
                ref.invalidate(correctQuestionProivder);
                Navigator.pushNamed(context, homePage);
              },
              child: Text("Exit")),
        ]),
      ),
    );
  }
}
