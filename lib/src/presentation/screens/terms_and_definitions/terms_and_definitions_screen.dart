import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/entity/quiz_item.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/base/loadable.dart';
import 'package:liana/src/presentation/common/platform_button.dart';
import 'package:liana/src/presentation/common/platform_list_tile.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_sectioned_list.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/common/show_platform_bottom_sheet.dart';
import 'package:liana/src/presentation/common/show_platform_dialog.dart';
import 'package:liana/src/presentation/navigation/routes.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_cubit.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/cubit/terms_and_definitions_screen_state.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/widgets/edit_term_and_definition_form.dart';
import 'package:liana/src/presentation/screens/terms_and_definitions/widgets/term_and_definition_list_item.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class TermsAndDefinitionsScreen extends StatefulWidget {
  const TermsAndDefinitionsScreen({
    required this.module,
    this.previousPageTitle,
    super.key,
  });

  final Module module;
  final String? previousPageTitle;

  @override
  State<TermsAndDefinitionsScreen> createState() =>
      _TermsAndDefinitionsScreenState();
}

class _TermsAndDefinitionsScreenState extends State<TermsAndDefinitionsScreen>
    with
        CubitHelper<TermsAndDefinitionsScreenCubit,
            TermsAndDefinitionsScreenState> {
  final formKey = GlobalKey<FormState>();

  void _onAddTermAndDefinitionButtonPressed(
    BuildContext context,
    TermsAndDefinitionsScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      minHeight: 560,
      isScrollControlled: true,
      child: EditTermAndDefinitionForm(
        formKey: formKey,
        title: 'terms_and_definitions_screen_create_term'.tr(),
        module: widget.module,
        onSubmitForm: (termAndDefinition) => _onCreateTermAndDefinitionSubmit(
          cubit,
          termAndDefinition,
        ),
        termValidator: cubit?.validateTerm ?? (_) => null,
        definitionValidator: cubit?.validateDefinition ?? (_) => null,
      ),
    );
  }

  void _onCreateTermAndDefinitionSubmit(
    TermsAndDefinitionsScreenCubit? cubit,
    TermAndDefinition termAndDefinition,
  ) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onCreateTermAndDefinition(termAndDefinition);
      rootNavigator(context)?.pop();
    }
  }

  void _onEditTermAndDefinitionButtonPressed(
    BuildContext context,
    TermAndDefinition termAndDefinition,
    TermsAndDefinitionsScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      minHeight: 560,
      isScrollControlled: true,
      child: EditTermAndDefinitionForm(
        formKey: formKey,
        title: 'terms_and_definitions_screen_update_term'.tr(),
        termAndDefinitionToEdit: termAndDefinition,
        module: widget.module,
        onSubmitForm: (termAndDefinition) => _onEditTermAndDefinitionSubmit(
          cubit,
          termAndDefinition,
        ),
        termValidator: cubit?.validateTerm ?? (_) => null,
        definitionValidator: cubit?.validateDefinition ?? (_) => null,
      ),
    );
  }

  void _onEditTermAndDefinitionSubmit(
    TermsAndDefinitionsScreenCubit? cubit,
    TermAndDefinition termAndDefinition,
  ) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onUpdateTermAndDefinition(termAndDefinition);
      rootNavigator(context)?.pop();
    }
  }

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
  ) {
    if (state.termsAndDefinitions.isNotEmpty) {
      navigator(context)?.push(
        createQuizScreenRoute(
          _getTermDefinitionQuizItems(state.termsAndDefinitions),
          'terms_and_definitions_screen_term_definition'.tr(),
          widget.module.name,
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
  ) {
    if (state.termsAndDefinitions.isNotEmpty) {
      navigator(context)?.push(
        createQuizScreenRoute(
          _getDefinitionTermQuizItems(state.termsAndDefinitions),
          'terms_and_definitions_screen_definition_term'.tr(),
          widget.module.name,
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
            title: Text('error_dialog_tittle'.tr()),
            actions: [
              PlatformDialogAction(
                isDefaultAction: true,
                onPressed: () => _onDismissErrorDialog(context),
                text: 'dialog_ok_button'.tr(),
              ),
            ],
          );
        }
      },
      builder: (_, state) => Loadable(
        isLoading: state.isLoading,
        child: PlatformScaffold(
          topAppBar: platformTopAppBar(
            title: Text(widget.module.name),
            previousPageTitle: widget.previousPageTitle,
            trailing: PlatformButton(
              padding: const EdgeInsets.all(10),
              onPressed: () => _onAddTermAndDefinitionButtonPressed(
                context,
                cubit(context),
              ),
              child: const Icon(CupertinoIcons.add),
            ),
          ),
          body: PlatformSectionedList(
            listSections: [
              PlatformListSection(
                header: Text(
                  'terms_and_definitions_screen_learn'.tr(),
                  style: _getListSectionHeaderTextStyle(context),
                ),
                children: [
                  PlatformListTile(
                    title: Text(
                      'terms_and_definitions_screen_term_definition'.tr(),
                    ),
                    onTap: () => _navigateToTermDefinitionQuizScreen(state),
                  ),
                  PlatformListTile(
                    title: Text(
                      'terms_and_definitions_screen_definition_term'.tr(),
                    ),
                    onTap: () => _navigateToDefinitionTermQuizScreen(state),
                  ),
                ],
              ),
              PlatformListSection(
                header: Text(
                  'terms_and_definitions_screen_terms'.tr(),
                  style: _getListSectionHeaderTextStyle(context),
                ),
                children: [
                  for (final termAndDefinition in state.termsAndDefinitions)
                    TermAndDefinitionListItem(
                      termAndDefinition: termAndDefinition,
                      onEditPressed: (termAndDefinition) =>
                          _onEditTermAndDefinitionButtonPressed(
                        context,
                        termAndDefinition,
                        cubit(context),
                      ),
                      onDeletePressed: (termAndDefinition) => cubit(context)
                          ?.onDeleteTermAndDefinition(termAndDefinition),
                      onIsFavoritePressed: (termAndDefinition) =>
                          cubit(context)?.onToggleIsTermAndDefinitionFavorite(
                        termAndDefinition,
                      ),
                    ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _onAddTermAndDefinitionButtonPressed(
              context,
              cubit(context),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
