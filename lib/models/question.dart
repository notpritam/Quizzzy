import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String category;
  final String id;
  final String correctAnswer;
  final List incorrectAnswers;
  final String question;
  final List tags;
  final String difficulty;
  final bool isNiche = false;

  Question(
      {required this.id,
      required this.category,
      required this.correctAnswer,
      required this.incorrectAnswers,
      required this.question,
      required this.difficulty,
      required this.tags});

  Question copyWith({
    String? category,
    String? id,
    String? correctAnswer,
    List? incorrectAnswers,
    String? question,
    List? tags,
    String? difficulty,
  }) {
    return Question(
      category: category ?? this.category,
      id: id ?? this.id,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      question: question ?? this.question,
      tags: tags ?? this.tags,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'id': id,
      'correctAnswer': correctAnswer,
      'incorrectAnswers': incorrectAnswers,
      'question': question,
      'tags': tags,
      'difficulty': difficulty,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      category: map['category'] as String,
      id: map['id'] as String,
      correctAnswer: map['correctAnswer'] as String,
      incorrectAnswers: List.from((map['incorrectAnswers'] as List)),
      question: map['question'] as String,
      tags: List.from((map['tags'] as List)),
      difficulty: map['difficulty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(category: $category, id: $id, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers, question: $question, tags: $tags, difficulty: $difficulty)';
  }
}
