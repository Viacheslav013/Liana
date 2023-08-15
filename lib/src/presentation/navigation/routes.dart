import 'package:flutter/cupertino.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/entity/quiz_item.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/modules/cubit/modules_screen_cubit.dart';
import 'package:liana/src/presentation/screens/modules/modules_screen.dart';
import 'package:liana/src/presentation/screens/quiz_screen/cubit/quiz_screen_cubit.dart';
import 'package:liana/src/presentation/screens/quiz_screen/quiz_screen.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_cubit.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/terms_and_definitions_screen.dart';

PageRoute createModulesScreenRoute(
  Folder folder, [
  String? previousPageTitle,
]) {
  return cubitScreen<ModulesScreenCubit>(
    ModulesScreenContent(folder: folder, previousPageTitle: previousPageTitle),
    onCreate: (cubit) => cubit.onCreate(folder),
  );
}

PageRoute createTermsAndDefinitionsScreenRoute(
  Module module, [
  String? previousPageTitle,
]) {
  return cubitScreen<TermsAndDefinitionsScreenCubit>(
    TermsAndDefinitionsScreen(
      module: module,
      previousPageTitle: previousPageTitle,
    ),
    onCreate: (cubit) => cubit.onCreate(module),
  );
}

PageRoute createQuizScreenRoute(
  List<QuizItem> quizItems,
  String pageTitle, [
  String? previousPageTitle,
]) {
  return cubitScreen<QuizScreenCubit>(
    QuizScreen(pageTitle: pageTitle, previousPageTitle: previousPageTitle),
    onCreate: (cubit) => cubit.onCreate(quizItems),
  );
}
