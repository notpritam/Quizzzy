import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:quiz_app/routes/routesName.dart';

import 'package:quiz_app/util/state/questionState.dart';
import 'package:quiz_app/util/theme.dart';

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
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text("Quizzy"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Question ${questionIndex + 1}/10")),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color(0xFFFFCC70),
                  Color(0xFFC850C0),
                  Color(0xFF4158D0),
                ])),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minHeight: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.white30),
                                    gradient: const LinearGradient(
                                      colors: [Colors.white60, Colors.white10],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                    )),
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Text(
                                    questionTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: quizButtonTheme,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            (options[0] == correctAnswer)
                                ? ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text("Correct Answer"),
                                    backgroundColor: Colors.green,
                                  ))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Wrong answer, Correct answer is $correctAnswer."),
                                        backgroundColor: Colors.red));
                            checkAnswer(0);
                          },
                          child: Text(options[0])),
                      SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                          style: quizButtonTheme,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            (options[1] == correctAnswer)
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Correct Answer"),
                                        backgroundColor: Colors.green))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Wrong answer, Correct answer is $correctAnswer."),
                                        backgroundColor: Colors.red));
                            checkAnswer(1);
                          },
                          child: Text(options[1])),
                      SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                          style: quizButtonTheme,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            (options[2] == correctAnswer)
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Correct Answer"),
                                        backgroundColor: Colors.green))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Wrong answer, Correct answer is $correctAnswer."),
                                        backgroundColor: Colors.red));
                            checkAnswer(2);
                          },
                          child: Text(options[2])),
                      SizedBox(
                        height: 4,
                      ),
                      ElevatedButton(
                          style: quizButtonTheme,
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            (options[3] == correctAnswer)
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Correct Answer"),
                                        backgroundColor: Colors.green))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Wrong answer, Correct answer is $correctAnswer."),
                                        backgroundColor: Colors.red));
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
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
