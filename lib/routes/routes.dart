import 'package:flutter/material.dart';
import 'package:quiz_app/pages/HomeScreen.dart';
import 'package:quiz_app/pages/LevelScreen.dart';
import 'package:quiz_app/pages/LoginScreen.dart';
import 'package:quiz_app/pages/ProfileScreen.dart';
import 'package:quiz_app/pages/QuizScreen.dart';
import 'package:quiz_app/pages/ResultScreen.dart';
import 'package:quiz_app/pages/SignUpScreen.dart';
import 'package:quiz_app/pages/SplashScreen.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/auth_checker.dart';

class MyRotes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case signUpPage:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case levelPage:
        return MaterialPageRoute(
          builder: (context) => LevelScreen(),
        );
      case quizPage:
        return MaterialPageRoute(
          builder: (context) => QuizScreen(),
        );
      case resultPage:
        var scoreValue = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: scoreValue,
          ),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case checkAuth:
        return MaterialPageRoute(
          builder: (context) => AuthChecker(),
        );
        break;
    }
    return MaterialPageRoute(
      builder: (context) => SplashScreen(),
    );
  }
}
