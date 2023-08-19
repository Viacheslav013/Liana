import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/answer_status.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/common/show_platform_dialog.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/quiz_screen/cubit/quiz_screen_cubit.dart';
import 'package:liana/src/presentation/screens/quiz_screen/cubit/quiz_screen_state.dart';
import 'package:liana/src/presentation/screens/quiz_screen/widgets/quiz_text_field.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.pageTitle,
    this.previousPageTitle,
    super.key,
  });

  final String pageTitle;
  final String? previousPageTitle;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with CubitHelper<QuizScreenCubit, QuizScreenState> {
  final answerTextController = TextEditingController();

  @override
  void initState() {
    answerTextController.addListener(_answerTextListener);
    super.initState();
  }

  @override
  void dispose() {
    answerTextController
      ..removeListener(_answerTextListener)
      ..dispose();
    super.dispose();
  }

  void _answerTextListener() {
    // ignore: no-empty-block
    setState(() {});
  }

  TextStyle? _getQuestionTextStyle() {
    if (Platform.isIOS) {
      return CupertinoTheme.of(context).textTheme.navTitleTextStyle;
    }

    return Theme.of(context).textTheme.titleMedium;
  }

  void _stateListener(QuizScreenState state) {
    switch (state.answerStatus) {
      case AnswerStatus.correct:
        _onCorrectAnswer(state);
        break;
      case AnswerStatus.wrong || AnswerStatus.unlearned:
        _onWrongOrUnlearnedAnswer(state);
        break;
      case null:
        return;
    }
  }

  void _onCorrectAnswer(QuizScreenState state) {
    if (state.isLastQuizItem) {
      _showQuizCompletionDialog(state);
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        _displayNextQuestion,
      );
    }
  }

  void _onWrongOrUnlearnedAnswer(QuizScreenState state) {
    answerTextController.text = state.quizItems[state.quizItemIndex].answer;
  }

  void _onAnswerSubmit(QuizScreenState state) {
    if (state.answerStatus == null) {
      cubit(context)?.onAnswer(answerTextController.text);
    }

    if (state.answerStatus == AnswerStatus.wrong ||
        state.answerStatus == AnswerStatus.unlearned) {
      if (state.isLastQuizItem) {
        _showQuizCompletionDialog(state);
      } else {
        _displayNextQuestion();
      }
    }
  }

  void _displayNextQuestion() {
    answerTextController.text = '';
    cubit(context)?.onDisplayNextQuestion();
  }

  void _showQuizCompletionDialog(QuizScreenState state) {
    showPlatformDialog(
      context: context,
      barrierDismissible: false,
      title: Text('quiz_screen_done'.tr()),
      content: Text(
        'quiz_screen_quiz_result'.tr(
          args: ['${state.correctAnswersCount}/${state.quizItems.length}'],
        ),
      ),
      actions: [
        PlatformDialogAction(
          text: 'dialog_ok_button'.tr(),
          isDefaultAction: true,
          onPressed: _endQuiz,
        ),
      ],
    );
  }

  void _endQuiz() {
    navigator(context)?.pop();
    rootNavigator(context)?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return consume(
      listener: (_, state) => _stateListener(state),
      builder: (_, state) => PlatformScaffold(
        topAppBar: platformTopAppBar(
          title: Text(widget.pageTitle),
          previousPageTitle: widget.previousPageTitle,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    state.quizItems[state.quizItemIndex].question,
                    style: _getQuestionTextStyle(),
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: QuizTextField(
                    controller: answerTextController,
                    onSubmit: () => _onAnswerSubmit(state),
                    onUnlearnedTap: () => cubit(context)?.onUnlearnedAnswer(),
                    answerStatus: state.answerStatus,
                  ),
                ),
              ),
              Flexible(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
