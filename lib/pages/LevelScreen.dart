import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/theme.dart';

import '../util/state/questionState.dart';
import './HomeScreen.dart';

class LevelScreen extends ConsumerWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Choose Your Level"),
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
        padding: const EdgeInsets.only(top: 20),
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (context, index, realIndex) {
                return carosuelWidget(context, ref, index);
              },
              options: CarouselOptions(height: 500, enlargeCenterPage: true),
            )
          ]),
        ),
      ),
    );
  }

  Center carosuelWidget(BuildContext context, WidgetRef ref, int postion) {
    String text = "";
    String url = "";
    if (postion == 0) {
      text = "Easy";
      url = "https://cdn-icons-png.flaticon.com/512/6009/6009627.png";
    } else if (postion == 1) {
      text = "Medium";
      url = "https://cdn-icons-png.flaticon.com/512/3063/3063835.png";
    } else if (postion == 2) {
      text = "Hard";
      url = "https://cdn-icons-png.flaticon.com/512/2405/2405308.png";
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, quizPage);
              if (postion == 0) {
                print("easy");
                ref.read(level.notifier).state = "easy";
              } else if (postion == 1) {
                print("medium");
                ref.read(level.notifier).state = "medium";
              } else if (postion == 2) {
                print("haard");
                ref.read(level.notifier).state = "hard";
              }
              ref
                  .read(questionProvider.notifier)
                  .getQuestionFinal(ref.read(category), ref.read(level));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 400,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white30),
                      gradient: const LinearGradient(
                        colors: [Colors.white60, Colors.white10],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        url,
                        width: 64,
                        height: 64,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        text,
                        style: levelStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
