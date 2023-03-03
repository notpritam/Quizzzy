import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/pages/HomeScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/state/questionState.dart';
import 'package:quiz_app/util/theme.dart';

import 'QuizScreen.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int wrong = 10 - score;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Results"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFFFFCC70),
              Color(0xFFC850C0),
              Color(0xFF4158D0),
            ])),
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text("GAME OVER"),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white30),
                      gradient: const LinearGradient(
                        colors: [Colors.white60, Colors.white10],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )),
                  height: 150,
                  child: Center(
                      child: Text(
                    "You Scored : $score",
                    style: resultText,
                  )),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: resultButtonTheme,
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
                style: resultButtonTheme,
                onPressed: () {
                  ref.read(authRepositoryProvider).updateData(wrong, score);

                  ref.read(questionProvider.notifier).resetQuiz();
                  ref.invalidate(correctQuestionProivder);
                  Navigator.pushNamed(context, homePage);
                },
                child: Text("Exit")),
          ]),
        ),
      ),
    );
  }
}
