import 'package:freezed_annotation/freezed_annotation.dart';

part 'module.freezed.dart';

@freezed
class Module with _$Module {
  const factory Module({
    required int? id,
    required String name,
    required int folderId,
    required int numberOfTermsDefinitions,
  }) = _Module;
}
