import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/presentation/common/platform_form.dart';

class EditFolderForm extends StatefulWidget {
  const EditFolderForm({
    required this.formKey,
    required this.title,
    required this.folderNameValidator,
    required this.onSubmitForm,
    this.folderToEdit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final FormFieldValidator<String?> folderNameValidator;
  final Function(Folder) onSubmitForm;
  final Folder? folderToEdit;

  @override
  State<StatefulWidget> createState() {
    return _EditFolderFormState();
  }
}

class _EditFolderFormState extends State<EditFolderForm> {

  final folderNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    folderNameController.text = widget.folderToEdit?.name ?? '';
  }

  @override
  void dispose() {
    folderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: widget.formKey,
        child: PlatformFormSection(
          header: widget.title,
          children: [
            PlatformFormTextField(
              textEditingController: folderNameController,
              prefix: const Text('Имя папки'),
              placeholder: 'Папка',
              validator: widget.folderNameValidator,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              onEditingComplete: () => widget.onSubmitForm(
                Folder(
                  id: widget.folderToEdit?.id,
                  name: folderNameController.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
