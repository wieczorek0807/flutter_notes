part of 'add_note_cubit.dart';

@freezed
class AddNoteState with _$AddNoteState {
  const factory AddNoteState.initial() = _Initial;
  const factory AddNoteState.error({required String message}) = _Error;
  const factory AddNoteState.submitting() = _Submitting;
  const factory AddNoteState.success() = _Success;
}
