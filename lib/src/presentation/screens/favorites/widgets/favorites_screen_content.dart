import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/quiz_item.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/base/loadable.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_sectioned_list.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/common/show_platform_dialog.dart';
import 'package:liana/src/presentation/navigation/routes.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/favorites/cubit/favorites_cubit.dart';
import 'package:liana/src/presentation/screens/favorites/widgets/favorite_term_and_definition_list_item.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_state.dart';

class FavoritesScreenContent extends StatelessWidget
    with CubitHelper<FavoritesCubit, TermsAndDefinitionsScreenState> {
  const FavoritesScreenContent({super.key});

  void _onDismissErrorDialog(BuildContext context) {
    cubit(context)?.onDismissError();
    rootNavigator(context)?.pop();
  }

  TextStyle? _getListSectionHeaderTextStyle(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
        : Theme.of(context).textTheme.titleLarge;
  }

  void _navigateToTermDefinitionQuizScreen(
    TermsAndDefinitionsScreenState state,
    BuildContext context,
  ) {
    if (state.termsAndDefinitions.isNotEmpty) {
      navigator(context)?.push(
        createQuizScreenRoute(
          _getTermDefinitionQuizItems(state.termsAndDefinitions),
          'Термин - Определение',
          'Избранные',
        ),
      );
    }
  }

  List<QuizItem> _getTermDefinitionQuizItems(
    List<TermAndDefinition> termsAndDefinitions,
  ) {
    return termsAndDefinitions
        .map(
          (termAndDefinition) => QuizItem(
            question: termAndDefinition.term,
            answer: termAndDefinition.definition,
          ),
        )
        .toList();
  }

  void _navigateToDefinitionTermQuizScreen(
    TermsAndDefinitionsScreenState state,
    BuildContext context,
  ) {
    if (state.termsAndDefinitions.isNotEmpty) {
      navigator(context)?.push(
        createQuizScreenRoute(
          _getDefinitionTermQuizItems(state.termsAndDefinitions),
          'Определение - Термин',
          'Избранные',
        ),
      );
    }
  }

  List<QuizItem> _getDefinitionTermQuizItems(
    List<TermAndDefinition> termsAndDefinitions,
  ) {
    return termsAndDefinitions
        .map(
          (termAndDefinition) => QuizItem(
            question: termAndDefinition.definition,
            answer: termAndDefinition.term,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return consume(
      listener: (_, state) {
        if (state.error != null) {
          showPlatformDialog(
            context: context,
            title: const Text('Ошибка'),
            actions: [
              PlatformDialogAction(
                isDefaultAction: true,
                onPressed: () => _onDismissErrorDialog(context),
                text: 'ОК',
              ),
            ],
          );
        }
      },
      builder: (_, state) => Loadable(
        isLoading: state.isLoading,
        child: PlatformScaffold(
          topAppBar: platformTopAppBar(
            title: const Text('Избранные'),
          ),
          body: PlatformSectionedList(
            listSections: [
              PlatformListSection(
                header: Text(
                  'Тренажеры',
                  style: _getListSectionHeaderTextStyle(context),
                ),
                children: [
                  PlatformListTile(
                    title: const Text('Термин - Определение'),
                    onTap: () => _navigateToTermDefinitionQuizScreen(
                      state,
                      context,
                    ),
                  ),
                  PlatformListTile(
                    title: const Text('Определение - Термин'),
                    onTap: () => _navigateToDefinitionTermQuizScreen(
                      state,
                      context,
                    ),
                  ),
                ],
              ),
              PlatformListSection(
                header: Text(
                  'Термины',
                  style: _getListSectionHeaderTextStyle(context),
                ),
                children: [
                  for (final termAndDefinition in state.termsAndDefinitions)
                    FavoriteTermAndDefinitionListItem(
                      termAndDefinition: termAndDefinition,
                      onIsFavoritePressed: (termAndDefinition) =>
                          cubit(context)?.onToggleIsTermAndDefinitionFavorite(
                        termAndDefinition,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}