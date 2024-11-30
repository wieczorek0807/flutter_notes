import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/usecases/notes_usecase/notes_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notes_state.dart';
part 'notes_cubit.freezed.dart';

@singleton
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._notesUsecase) : super(const NotesState.initial()) {
    getNotes();
  }

  final NotesUsecase _notesUsecase;

  Future<void> getNotes() async {
    emit(const NotesState.loading());
    final result = await _notesUsecase.getAllNotes();

    result.fold(
      (failure) => emit(NotesState.error(message: failure.message)),
      (noteEntities) => emit(
        noteEntities.isEmpty ? const NotesState.initial() : NotesState.loaded(noteEntities: noteEntities),
      ),
    );
  }
}
