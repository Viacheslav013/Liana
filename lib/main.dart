import 'package:flutter/widgets.dart';
import 'package:liana/src/di/di_widget.dart';
import 'package:liana/src/liana_app.dart';

void main() {
  runApp(
    const DiWidget(
      child: LianaApp(),
    ),
  );
}
