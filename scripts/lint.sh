set -e

dart format --set-exit-if-changed .
flutter pub run dart_code_metrics:metrics analyze lib
flutter pub run dart_code_metrics:metrics check-unused-files lib
