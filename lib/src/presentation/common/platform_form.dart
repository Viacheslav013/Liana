import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liana/src/presentation/common/platform_widget.dart';

class PlatformFormSection extends PlatformWidget {
  const PlatformFormSection({
    required this.children,
    this.header,
    super.key,
  });

  final List<Widget> children;
  final String? header;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoFormSection(
      header: Text(
        header ?? '',
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      children: children,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null)
          Text(
            header ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (header != null) const SizedBox(height: 6),
        for (Widget formField in children)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: formField,
          ),
      ],
    );
  }
}

class PlatformFormTextField extends PlatformWidget {
  const PlatformFormTextField({
    this.textEditingController,
    this.prefix,
    this.placeholder,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onEditingComplete,
    this.validator,
    this.initialValue,
    super.key,
  });

  final TextEditingController? textEditingController;
  final Widget? prefix;
  final String? placeholder;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String?>? validator;
  final String? initialValue;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoTextFormFieldRow(
      controller: textEditingController,
      placeholder: placeholder,
      prefix: prefix,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      validator: validator,
      initialValue: initialValue,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Row(
      children: [
        if (prefix != null) prefix ?? Container(),
        const SizedBox(width: 8),
        Flexible(
          child: TextFormField(
            controller: textEditingController,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            textInputAction: textInputAction,
            onEditingComplete: onEditingComplete,
            validator: validator,
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: placeholder,
            ),
          ),
        ),
      ],
    );
  }
}
