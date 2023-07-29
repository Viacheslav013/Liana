import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:liana/src/domain/entity/folder.dart';

part 'library_screen_state.freezed.dart';

@freezed
class LibraryScreenState with _$LibraryScreenState {
  const factory LibraryScreenState({
    @Default([]) List<Folder> folders,
    @Default(true) bool isLoading,
    String? error,
  }) = _LibraryScreenState;
}
