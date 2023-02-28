import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/constants/image_strings.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/pages/LoginScreen.dart';
import 'package:quiz_app/util/auth_checker.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => AuthChecker())));
    return Stack(
      children: [
        SvgPicture.asset(
          splashBgImage2,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
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
        )
      ],
    );
  }
}
