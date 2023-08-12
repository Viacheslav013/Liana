import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/module.dart';
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
        title: 'Добавить термин',
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
        title: 'Редактировать термин',
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
                  'Тренажеры',
                  style: _getListSectionHeaderTextStyle(context),
                ),
                children: const [
                  PlatformListTile(
                    title: Text('Термин - Определение'),
                  ),
                  PlatformListTile(
                    title: Text('Определение - Термин'),
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
