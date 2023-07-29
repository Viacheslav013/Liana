import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required int? id,
    required String name,
  }) = _Folder;
}
