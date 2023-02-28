// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/util/getQuestions.dart';

final questionProvider =
    StateNotifierProvider<QuestionNotifier, QuestionsState>(
        (ref) => QuestionNotifier());

@immutable
class QuestionsState {}

class InitialQuestionsState extends QuestionsState {}

class LoadingQuestionsState extends QuestionsState {}

class LoadedQuestionState extends QuestionsState {
  LoadedQuestionState({
    required this.questions,
  });
  final List<Question> questions;
}

class ErrorQuestionState extends QuestionsState {
  final String message;
  ErrorQuestionState({
    required this.message,
  });
}

class QuestionNotifier extends StateNotifier<QuestionsState> {
  QuestionNotifier() : super(InitialQuestionsState());

  final GetQuestion _getQuestion = GetQuestion();

  getQuestionFinal(String cat, String lvl) async {
    try {
      state = LoadingQuestionsState();
      List<Question> questions = await _getQuestion.getQuestion(cat, lvl);
      state = LoadedQuestionState(questions: questions);
    } catch (e) {
      state = ErrorQuestionState(message: e.toString());
    }
  }

  resetQuiz() {
    state = InitialQuestionsState();
  }
}
