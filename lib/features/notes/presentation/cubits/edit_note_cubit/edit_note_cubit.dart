import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/note_entity/note_entity.dart';
import '../../../domain/services/notes_service/notes_service.dart';

part 'edit_note_cubit.freezed.dart';
part 'edit_note_state.dart';

@injectable
class EditNoteCubit extends Cubit<EditNoteState> {
  EditNoteCubit(this._notesService) : super(EditNoteState.initial());

  final NotesService _notesService;

  Future<void> editNote(String newContent, NoteEntity noteEntity) async {
    try {
      emit(const EditNoteState.loading());

      if (newContent.trim().isEmpty) {
        emit(const EditNoteState.error(message: 'Note cannot be empty'));
        return;
      }

      final newNoteEntity = noteEntity.copyWith(content: newContent);

      final value = await _notesService.addNote(noteEntity: newNoteEntity);

      value.fold(
        (failure) => emit(EditNoteState.error(message: failure.message)),
        (_) => emit(const EditNoteState.success()),
      );
    } catch (e) {
      emit(EditNoteState.error(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
