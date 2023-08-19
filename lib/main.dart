import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:liana/src/di/di_widget.dart';
import 'package:liana/src/liana_app.dart';
import 'package:liana/src/presentation/localization/localization_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    const DiWidget(
      child: LocalizationWidget(
        child: LianaApp(),
      ),
    ),
  );
}
