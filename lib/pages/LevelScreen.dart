import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/routes/routesName.dart';

import '../util/state/questionState.dart';
import 'HomeScreen.dart';

class LevelScreen extends ConsumerWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Level")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Choose Your Level"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, quizPage);
                    ref.read(level.notifier).state = "easy";
                    ref
                        .read(questionProvider.notifier)
                        .getQuestionFinal(ref.read(category), ref.read(level));
                  },
                  child: Text("Easy")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, quizPage);
                    ref.read(level.notifier).state = "medium";
                    ref
                        .read(questionProvider.notifier)
                        .getQuestionFinal(ref.read(category), ref.read(level));
                  },
                  child: Text("Medium")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, quizPage);
                    ref.read(level.notifier).state = "hard";
                    ref
                        .read(questionProvider.notifier)
                        .getQuestionFinal(ref.read(category), ref.read(level));
                  },
                  child: Text("Hard")),
            ],
          ),
        ),
      ),
    );
  }
}
