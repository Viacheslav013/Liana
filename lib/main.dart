import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:liana/src/di/di_widget.dart';
import 'package:liana/src/liana_app.dart';
import 'package:liana/src/presentation/localization/localization_widget.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    const DiWidget(
      child: LocalizationWidget(
        onInitialized: FlutterNativeSplash.remove,
        child: LianaApp(),
      ),
    ),
  );
}
