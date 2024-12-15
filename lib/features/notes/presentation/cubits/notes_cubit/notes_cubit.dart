import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notes_cubit.freezed.dart';
part 'notes_state.dart';

@injectable
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._notesService) : super(const NotesState.initial()) {
    getNotes();
  }

  final NotesService _notesService;

  Future<void> deleteNote({required String noteId}) async {
    emit(const NotesState.loading());
    final result = await _notesService.deleteNote(noteId: noteId);
    result.fold((failure) => emit(NotesState.error(message: failure.message)),
        (_) async => await getNotes());
  }

  Future<void> getNotes() async {
    emit(const NotesState.loading());
    final result = await _notesService.getNotes();

    result.fold(
      (failure) => emit(NotesState.error(message: failure.message)),
      (noteEntities) => emit(
        noteEntities.isEmpty
            ? const NotesState.initial()
            : NotesState.loaded(noteEntities: noteEntities),
      ),
    );
  }
}
