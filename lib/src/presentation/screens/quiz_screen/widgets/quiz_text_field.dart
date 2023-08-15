import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/answer_status.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';
import 'package:liana/src/presentation/themes/colors.dart';
import 'package:liana/src/presentation/themes/material_themes.dart';

class QuizTextField extends PlatformWidget {
  const QuizTextField({
    required this.controller,
    required this.onSubmit,
    required this.onUnlearnedTap,
    required this.answerStatus,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onUnlearnedTap;
  final AnswerStatus? answerStatus;

  Color _getTextFieldColor(BuildContext context) {
    if (answerStatus == null || answerStatus == AnswerStatus.unlearned) {
      return Platform.isIOS
          ? CupertinoTheme.of(context).primaryColor
          : lightColorScheme.primary;
    }

    return answerStatus == AnswerStatus.correct
        ? correctAnswerColor
        : wrongAnswerColor;
  }

  String _getHelperText() {
    final localAnswerStatus = answerStatus;
    if (localAnswerStatus == null) {
      return 'Введите ответ';
    }

    switch (localAnswerStatus) {
      case AnswerStatus.correct:
        return 'Правильно';
      case AnswerStatus.wrong:
        return 'Неправильно';
      case AnswerStatus.unlearned:
        return '';
    }
  }

  Color? _getHelperTextColor(BuildContext context) {
    return answerStatus == null || answerStatus == AnswerStatus.unlearned
        ? null
        : _getTextFieldColor(context);
  }

  Widget _buildSuffix(BuildContext context) {
    return GestureDetector(
      onTap: onUnlearnedTap,
      child: Text(
        'Не знаю',
        style: TextStyle(
          color: _getTextFieldColor(context),
        ),
      ),
    );
  }

  InputBorder _buildMaterialInputBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: _getTextFieldColor(context),
        strokeAlign: 0,
      ),
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField.borderless(
          controller: controller,
          padding: const EdgeInsets.only(bottom: 6),
          cursorColor: _getTextFieldColor(context),
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          onEditingComplete: onSubmit,
          suffix: controller.text.isEmpty ? _buildSuffix(context) : null,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _getTextFieldColor(context),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _getHelperText(),
          style: TextStyle(
            color: _getHelperTextColor(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: _getTextFieldColor(context),
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      onEditingComplete: onSubmit,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 6),
        isDense: true,
        enabledBorder: _buildMaterialInputBorder(context),
        focusedBorder: _buildMaterialInputBorder(context),
        helperText: _getHelperText(),
        helperStyle: TextStyle(
          color: _getHelperTextColor(context),
        ),
        suffixIcon: controller.text.isEmpty ? _buildSuffix(context) : null,
        suffixIconConstraints: const BoxConstraints(maxHeight: 20),
      ),
    );
  }
}
