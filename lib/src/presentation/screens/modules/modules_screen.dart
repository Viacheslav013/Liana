import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/base/loadable.dart';
import 'package:liana/src/presentation/common/platform_button.dart';
import 'package:liana/src/presentation/common/platform_divider.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/common/show_platform_bottom_sheet.dart';
import 'package:liana/src/presentation/common/show_platform_dialog.dart';
import 'package:liana/src/presentation/navigation/routes.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/modules/cubit/modules_screen_cubit.dart';
import 'package:liana/src/presentation/screens/modules/cubit/modules_screen_state.dart';
import 'package:liana/src/presentation/screens/modules/widgets/edit_module_form.dart';
import 'package:liana/src/presentation/screens/modules/widgets/module_list_item.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class ModulesScreenContent extends StatefulWidget {
  const ModulesScreenContent({
    required this.folder,
    this.previousPageTitle,
    super.key,
  });

  final Folder folder;
  final String? previousPageTitle;

  @override
  State<ModulesScreenContent> createState() => _ModulesScreenContentState();
}

class _ModulesScreenContentState extends State<ModulesScreenContent>
    with CubitHelper<ModulesScreenCubit, ModulesScreenState> {
  final formKey = GlobalKey<FormState>();

  void _onAddModuleButtonPressed(
    BuildContext context,
    ModulesScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      minHeight: 500,
      child: EditModuleForm(
        formKey: formKey,
        title: 'Создать модуль',
        folder: widget.folder,
        onSubmitForm: (module) => _onCreateModuleSubmit(cubit, module),
        moduleNameValidator: cubit?.validateModuleName ?? (_) => null,
      ),
    );
  }

  void _onCreateModuleSubmit(ModulesScreenCubit? cubit, Module module) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onCreateModule(module);
      rootNavigator(context)?.pop();
    }
  }

  void _onEditModuleButtonPressed(
    BuildContext context,
    Module module,
    ModulesScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      minHeight: 500,
      child: EditModuleForm(
        formKey: formKey,
        title: 'Редактировать модуль',
        folder: widget.folder,
        moduleToEdit: module,
        onSubmitForm: (module) => _onEditModuleSubmit(cubit, module),
        moduleNameValidator: cubit?.validateModuleName ?? (_) => null,
      ),
    );
  }

  void _onEditModuleSubmit(ModulesScreenCubit? cubit, Module module) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onUpdateModule(module);
      rootNavigator(context)?.pop();
    }
  }

  void _onDismissErrorDialog(BuildContext context) {
    cubit(context)?.onDismissError();
    rootNavigator(context)?.pop();
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
      builder: (_, state) => PlatformScaffold(
        topAppBar: platformTopAppBar(
          title: Text(widget.folder.name),
          previousPageTitle: widget.previousPageTitle,
          trailing: PlatformButton(
            padding: const EdgeInsets.all(10),
            onPressed: () => _onAddModuleButtonPressed(context, cubit(context)),
            child: const Icon(CupertinoIcons.add),
          ),
        ),
        body: Loadable(
          isLoading: state.isLoading,
          child: ListView.separated(
            itemCount: state.modules.length,
            separatorBuilder: (_, __) => const PlatformDivider(),
            itemBuilder: (_, index) => ModuleListItem(
              module: state.modules[index],
              onTap: (module) => navigator(context)?.push(
                createTermsAndDefinitionsScreenRoute(
                  state.modules[index],
                  'Модули',
                ),
              ),
              onEditPressed: (module) => _onEditModuleButtonPressed(
                context,
                module,
                cubit(context),
              ),
              onDeletePressed: (module) =>
                  cubit(context)?.onDeleteModule(module),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddModuleButtonPressed(context, cubit(context)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
