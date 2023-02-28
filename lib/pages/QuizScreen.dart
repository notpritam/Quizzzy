// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/pages/ResultScreen.dart';

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
      final questionTitle = questionData.questions[questionIndex].question;
      final options = [];
      final correctAnswer = questionData.questions[questionIndex].correctAnswer;

      questionData.questions[questionIndex].incorrectAnswers.forEach((element) {
        options.add(element);
      });
      options.add(correctAnswer);

      options.shuffle();

      void checkAnswer(int postion) {
        // ignore: deprecated_member_use
        if (options[postion] == correctAnswer) {
          ref.read(correctQuestionProivder.state).state++;
          print("Correct Answer");
        }

        if (9 < questionIndex) {
          ref.invalidate(questionIndexProivder);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(score: correctQuestion),
              ));
        } else {
          ref.read(questionIndexProivder.state).state++;
        }
        print(correctQuestion);
        print(questionIndex);
      }

      return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text("Quizzy"),
          actions: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text("4:28"),
            )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Expanded(
            child: Column(children: [
              Center(
                child: Card(
                  child: Column(children: [
                    Text(
                      // (questionIndex + 1).toString() as String,
                      correctAnswer,
                      textAlign: TextAlign.right,
                    ),
                    Text(questionData.questions[questionIndex].question),
                  ]),
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
        ),
      );
    }

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
