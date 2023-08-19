import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/domain/entity/module.dart';
import 'package:liana/src/domain/entity/term_and_definition.dart';
import 'package:liana/src/presentation/common/platform_form.dart';

class EditTermAndDefinitionForm extends StatefulWidget {
  const EditTermAndDefinitionForm({
    required this.formKey,
    required this.title,
    required this.termValidator,
    required this.definitionValidator,
    required this.onSubmitForm,
    required this.module,
    this.termAndDefinitionToEdit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final FormFieldValidator<String?> termValidator;
  final FormFieldValidator<String?> definitionValidator;
  final void Function(TermAndDefinition) onSubmitForm;
  final Module module;
  final TermAndDefinition? termAndDefinitionToEdit;

  @override
  State<EditTermAndDefinitionForm> createState() =>
      _EditTermAndDefinitionFormState();
}

class _EditTermAndDefinitionFormState extends State<EditTermAndDefinitionForm> {
  final termTextController = TextEditingController();
  final definitionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    termTextController.text = widget.termAndDefinitionToEdit?.term ?? '';
    definitionController.text =
        widget.termAndDefinitionToEdit?.definition ?? '';
  }

  @override
  void dispose() {
    termTextController.dispose();
    definitionController.dispose();
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
              textEditingController: termTextController,
              prefix: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  'terms_and_definitions_screen_term_input_title'.tr(),
                ),
              ),
              placeholder:
                  'terms_and_definitions_screen_term_input_placeholder'.tr(),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              validator: widget.termValidator,
            ),
            PlatformFormTextField(
              textEditingController: definitionController,
              prefix: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  'terms_and_definitions_screen_definition_input_title'.tr(),
                ),
              ),
              placeholder:
                  'terms_and_definitions_screen_definition_input_placeholder'
                      .tr(),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              validator: widget.definitionValidator,
              onEditingComplete: () => widget.onSubmitForm(
                TermAndDefinition(
                  id: widget.termAndDefinitionToEdit?.id,
                  term: termTextController.text,
                  definition: definitionController.text,
                  moduleId: widget.module.id ?? -1,
                  isFavorite:
                      widget.termAndDefinitionToEdit?.isFavorite ?? false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
