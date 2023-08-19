import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
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
      return 'quiz_screen_answer_support_text'.tr();
    }

    switch (localAnswerStatus) {
      case AnswerStatus.correct:
        return 'quiz_screen_correct'.tr();
      case AnswerStatus.wrong:
        return 'quiz_screen_incorrect'.tr();
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
        'quiz_screen_unlearned'.tr(),
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
