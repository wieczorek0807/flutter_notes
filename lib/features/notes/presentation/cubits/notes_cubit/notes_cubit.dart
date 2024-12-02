import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

@injectable
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._notesService) : super(const NotesState.initial()) {
    getNotes();
  }

  final NotesService _notesService;

  Future<void> getNotes() async {
    print('NotesCubit - getNotes() called');
    emit(const NotesState.loading());
    final result = await _notesService.getNotes();

    result.fold(
      (failure) => emit(NotesState.error(message: failure.message)),
      (noteEntities) => emit(
        noteEntities.isEmpty ? const NotesState.initial() : NotesState.loaded(noteEntities: noteEntities),
      ),
    );
  }
}
