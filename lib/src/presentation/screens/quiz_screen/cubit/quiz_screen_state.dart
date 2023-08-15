import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:liana/src/domain/entity/answer_status.dart';
import 'package:liana/src/domain/entity/quiz_item.dart';

part 'quiz_screen_state.freezed.dart';

@freezed
class QuizScreenState with _$QuizScreenState {
  const QuizScreenState._();

  const factory QuizScreenState({
    @Default([]) List<QuizItem> quizItems,
    AnswerStatus? answerStatus,
    @Default(0) int quizItemIndex,
    @Default(0) int correctAnswersCount,
  }) = _QuizScreenState;

  bool get isLastQuizItem => quizItemIndex == quizItems.length - 1;
}
