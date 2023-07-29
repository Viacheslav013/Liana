import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/presentation/base/cubit_helper.dart';
import 'package:liana/src/presentation/base/loadable.dart';
import 'package:liana/src/presentation/common/platform_button.dart';
import 'package:liana/src/presentation/common/platform_scaffold.dart';
import 'package:liana/src/presentation/common/platform_top_app_bar.dart';
import 'package:liana/src/presentation/common/show_platform_bottom_sheet.dart';
import 'package:liana/src/presentation/common/show_platform_dialog.dart';
import 'package:liana/src/presentation/navigation/utils.dart';
import 'package:liana/src/presentation/screens/library/cubit/library_screen_cubit.dart';
import 'package:liana/src/presentation/screens/library/cubit/library_screen_state.dart';
import 'package:liana/src/presentation/screens/library/widgets/edit_folder_form.dart';
import 'package:liana/src/presentation/screens/library/widgets/folder_list_item.dart';
import 'package:liana/src/presentation/themes/cupertino_themes.dart';

class LibraryScreenContent extends StatefulWidget {
  const LibraryScreenContent({super.key});

  @override
  State<LibraryScreenContent> createState() => _LibraryScreenContentState();
}

class _LibraryScreenContentState
    extends State<LibraryScreenContent>
    with CubitHelper<LibraryScreenCubit, LibraryScreenState> {

  final formKey = GlobalKey<FormState>();

  void _onAddFolderButtonPressed(
    BuildContext context,
    LibraryScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      iosHeight: 500,
      child: EditFolderForm(
        formKey: formKey,
        title: 'Создать папку',
        onSubmitForm: (folder) => _onCreateFolderFormSubmit(cubit, folder),
        folderNameValidator: cubit?.validateFolderName ?? (_) => null,
      ),
    );
  }

  void _onCreateFolderFormSubmit(LibraryScreenCubit? cubit, Folder folder) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onCreateFolder(folder);
      rootNavigator(context)?.pop();
    }
  }

  void _onEditFolderButtonPressed(
      BuildContext context,
      Folder folder,
      LibraryScreenCubit? cubit,
  ) {
    showPlatformBottomSheet(
      context: rootNavigator(context)?.context ?? context,
      iosBackgroundColor: getFormBottomSheetSheetBackgroundColor(context),
      iosHeight: 500,
      child: EditFolderForm(
        formKey: formKey,
        folderToEdit: folder,
        title: 'Редактировать папку',
        onSubmitForm: (folder) => _onEditFolderFormSubmit(cubit, folder),
        folderNameValidator: cubit?.validateFolderName ?? (_) => null,
      ),
    );
  }

  void _onEditFolderFormSubmit(LibraryScreenCubit? cubit, Folder folder) {
    if (formKey.currentState?.validate() == true) {
      cubit?.onUpdateFolder(folder);
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
            content: Text(state.error ?? ''),
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
          title: const Text('Библиотека'),
          trailing: PlatformButton(
            padding: const EdgeInsets.all(10),
            onPressed: () => _onAddFolderButtonPressed(
              context,
              cubit(context),
            ),
            child: const Icon(CupertinoIcons.add),
          ),
        ),
        body: Loadable(
          isLoading: state.isLoading,
          child: ListView.separated(
            itemBuilder: (_, index) => FolderListItem(
              onEditClick: (folder) => _onEditFolderButtonPressed(
                context,
                folder,
                cubit(context),
              ),
              onDeletePressed: (folder) =>
                cubit(context)?.onDeleteFolder(folder),
              folder: state.folders[index],
            ),
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemCount: state.folders.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddFolderButtonPressed(context, cubit(context)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
