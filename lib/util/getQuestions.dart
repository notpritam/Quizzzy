import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question.dart';

class GetQuestion {
  String baseUrl = "https://the-trivia-api.com/api/questions";
  String categories = "arts_and_literature";
  int limit = 10;
  String level = "easy";

  getQuestion(String cat, String lvl) async {
    List<Question> questions = [];
    try {
      Uri questionUrl =
          Uri.parse('$baseUrl?categories=$cat&limit=$limit&difficulty=$lvl');
      http.Response response = await http.get(questionUrl);
      if (response.statusCode == 200) {
        List<dynamic> questionList = jsonDecode(response.body);

        questionList.forEach((element) {
          Question question = Question.fromMap(element);
          questions.add(question);
        });
      }
      return questions;
    } catch (e) {
      print(e.toString());
    }

    return questions;
  }
}
