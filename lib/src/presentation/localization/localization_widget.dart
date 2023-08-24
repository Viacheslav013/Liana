import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/presentation/localization/supported_locales.dart';

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({
    required this.onInitialized,
    required this.child,
    super.key,
  });

  final VoidCallback onInitialized;
  final Widget child;

  Future<void> _initEasyLocalization() async {
    await EasyLocalization.ensureInitialized();
    onInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initEasyLocalization(),
      builder: (_, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? EasyLocalization(
                supportedLocales: supportedLocales.keys.toList(),
                path: 'assets/translations',
                fallbackLocale: supportedLocales.keys.first,
                child: child,
              ) : const SizedBox.shrink(),
    );
  }
}
