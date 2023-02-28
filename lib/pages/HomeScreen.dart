import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/category_list.dart';
import 'package:quiz_app/pages/QuizScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/util/state/questionState.dart';

final category = StateProvider((ref) => "");
final level = StateProvider((ref) => "");

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Quizzy"), actions: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(Icons.account_circle),
        ),
      ]),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Hey Pritam,\nWhat subject you want to learn today",
              softWrap: true,
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: List.generate(10, (index) => SingleCategory(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleCategory extends ConsumerWidget {
  final int index;

  SingleCategory(this.index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => {
        ref.read(category.notifier).state = CategoryList[index]['id'] as String,
        ref.read(level.notifier).state = "easy",
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(),
            )),
        ref
            .read(questionProvider.notifier)
            .getQuestionFinal(ref.read(category), ref.read(level)),
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.amber),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                CategoryList[index]['img'] as String,
                height: 72,
                width: 72,
              ),
              SizedBox(
                height: 10,
              ),
              Text(CategoryList[index]['name'] as String),
            ],
          ),
        ),
      ),
    );
  }
}
