import 'package:equatable/equatable.dart';

class QuestionsModel extends Equatable{
  final String question;
  final List<String> options;
  final int answerIndex;
  final int chosenAnswerIndex;

  const QuestionsModel({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.chosenAnswerIndex,
});

  @override
  List<Object?> get props => [
    chosenAnswerIndex,
    question,
    options,
    answerIndex,
  ];

}