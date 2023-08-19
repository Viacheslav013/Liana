import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/localization/supported_locales.dart';

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: supportedLocales.keys.toList(),
      path: 'assets/translations',
      fallbackLocale: supportedLocales.keys.first,
      child: child,
    );
  }
}
