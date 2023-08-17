import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:liana/src/domain/entity/answer_status.dart';
import 'package:liana/src/domain/entity/quiz_item.dart';
import 'package:liana/src/presentation/screens/quiz_screen/cubit/quiz_screen_state.dart';

@injectable
class QuizScreenCubit extends Cubit<QuizScreenState> {
  QuizScreenCubit() : super(const QuizScreenState());

  void onCreate(List<QuizItem> quizItems) {
    quizItems.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
    emit(state.copyWith(quizItems: quizItems));
  }

  void onAnswer(String answer) {
    final answerStatus =
        _isAnswerCorrect(answer) ? AnswerStatus.correct : AnswerStatus.wrong;
    final correctAnswersCount = answerStatus == AnswerStatus.correct
        ? state.correctAnswersCount + 1
        : state.correctAnswersCount;

    emit(
      state.copyWith(
        answerStatus: answerStatus,
        correctAnswersCount: correctAnswersCount,
      ),
    );
  }

  bool _isAnswerCorrect(String answer) {
    return state.quizItems[state.quizItemIndex].answer.trim().toLowerCase() ==
        answer.trim().toLowerCase();
  }

  void onUnlearnedAnswer() {
    emit(
      state.copyWith(
        answerStatus: AnswerStatus.unlearned,
      ),
    );
  }

  void onDisplayNextQuestion() {
    emit(
      state.copyWith(
        answerStatus: null,
        quizItemIndex: state.quizItemIndex + 1,
      ),
    );
  }
}
