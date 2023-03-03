import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/constants/image_strings.dart';
import 'package:quiz_app/routes/routesName.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),
        () => Navigator.popAndPushNamed(context, checkAuth));
    return Scaffold(
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
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quizzy",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text("Expand your knowledege"),
          ],
        )),
      ),
    );
  }
}
