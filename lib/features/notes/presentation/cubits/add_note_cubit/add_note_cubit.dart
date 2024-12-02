import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_note_state.dart';
part 'add_note_cubit.freezed.dart';

@injectable
class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this._notesService) : super(const AddNoteState.initial());

  final NotesService _notesService;

  Future<void> saveNote(String content) async {
    try {
      emit(const AddNoteState.loading());

      if (content.trim().isEmpty) {
        emit(const AddNoteState.error(message: 'Note cannot be empty'));
        return;
      }

      final noteEntity = NoteEntity.createNewNote(content: content);

      final value = await _notesService.addNote(noteEntity: noteEntity);

      value.fold(
        (failure) => emit(AddNoteState.error(message: failure.message)),
        (_) => emit(const AddNoteState.success()),
      );
    } catch (e) {
      emit(AddNoteState.error(message: 'An error occurred: ${e.toString()}'));
    }
  }
}
