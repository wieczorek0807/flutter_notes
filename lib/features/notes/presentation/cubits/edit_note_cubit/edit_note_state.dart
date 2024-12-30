part of 'edit_note_cubit.dart';

@freezed
class EditNoteState with _$EditNoteState {
  const factory EditNoteState.initial() = _Initial;
  const factory EditNoteState.error({required String message}) = _Error;
  const factory EditNoteState.editing({required NoteEntity noteEntity}) =
      _Editing;
  const factory EditNoteState.loading() = _Loading;
  const factory EditNoteState.success() = _Success;
}
