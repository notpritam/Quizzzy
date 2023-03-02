import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:quiz_app/routes/routesName.dart';

import 'package:quiz_app/util/state/questionState.dart';

final questionIndexProivder = StateProvider.autoDispose((ref) => 0);
final correctQuestionProivder = StateProvider.autoDispose((ref) => 0);

class QuizScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final QuestionsState questionData = ref.watch(questionProvider);
    final int questionIndex = ref.watch(questionIndexProivder);
    final int correctQuestion = ref.watch(correctQuestionProivder);

    if (questionData is LoadedQuestionState) {
      String questionTitle = "";
      List options = [];
      String correctAnswer = "";

      if (questionIndex <= 9) {
        questionTitle = questionData.questions[questionIndex].question;
        options = [];
        correctAnswer = questionData.questions[questionIndex].correctAnswer;
        questionData.questions[questionIndex].incorrectAnswers
            .forEach((element) {
          options.add(element);
        });
        options.add(correctAnswer);
        options.shuffle();
      }

      void checkAnswer(int postion) {
        if (options[postion] == correctAnswer) {
          ref.read(correctQuestionProivder.notifier).state++;
          print("Correct Answer");
        }

        if (8 < questionIndex) {
          ref.invalidate(questionIndexProivder);
          Navigator.pushReplacementNamed(context, resultPage,
              arguments: ref.read(correctQuestionProivder));
        } else {
          ref.read(questionIndexProivder.notifier).state++;
        }

        print(correctQuestion);
        print(questionIndex);
      }

      Future<bool> _onWillPop() async {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text('Do you want to close the Quiz'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false), //<-- SEE HERE
                    child: new Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.popAndPushNamed(
                        context, homePage), // <-- SEE HERE
                    child: new Text('Yes'),
                  ),
                ],
              ),
            )) ??
            false;
      }

      return WillPopScope(
        onWillPop: () {
          return _onWillPop();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Quizzy"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Question ${questionIndex + 1}")),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(children: [
                  Center(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [
                          Text(questionTitle),
                        ]),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkAnswer(0);
                      },
                      child: Text(options[0])),
                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkAnswer(1);
                      },
                      child: Text(options[1])),
                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkAnswer(2);
                      },
                      child: Text(options[2])),
                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        checkAnswer(3);
                      },
                      child: Text(options[3])),
                  SizedBox(
                    height: 4,
                  ),
                ]),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
