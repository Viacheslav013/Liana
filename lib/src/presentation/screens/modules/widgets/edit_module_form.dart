import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/domain/entity/folder.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/presentation/common/platform_form.dart';

class EditModuleForm extends StatefulWidget {
  const EditModuleForm({
    required this.formKey,
    required this.title,
    required this.moduleNameValidator,
    required this.onSubmitForm,
    required this.folder,
    this.moduleToEdit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final FormFieldValidator<String?> moduleNameValidator;
  final void Function(Module) onSubmitForm;
  final Folder folder;
  final Module? moduleToEdit;

  @override
  State<StatefulWidget> createState() {
    return _EditModuleFormState();
  }
}

class _EditModuleFormState extends State<EditModuleForm> {
  final moduleNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    moduleNameController.text = widget.moduleToEdit?.name ?? '';
  }

  @override
  void dispose() {
    moduleNameController.dispose();
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
              textEditingController: moduleNameController,
              prefix: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text('modules_screen_module_name_input_title'.tr()),
              ),
              placeholder: 'modules_screen_module_name_input_placeholder'.tr(),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              validator: widget.moduleNameValidator,
              onEditingComplete: () => widget.onSubmitForm(
                Module(
                  id: widget.moduleToEdit?.id,
                  name: moduleNameController.text,
                  numberOfTermsDefinitions:
                      widget.moduleToEdit?.numberOfTermsDefinitions ?? 0,
                  folderId:
                      widget.moduleToEdit?.folderId ?? widget.folder.id ?? -1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
