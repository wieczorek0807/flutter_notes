import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';

abstract interface class INotesService {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity});
  Future<Either<Failure, void>> deleteNote({required String noteId});
}

@injectable
class NotesService with UiLoggy implements INotesService {
  final NotesRepository _repository;

  NotesService(this._repository);

  @override
  Future<Either<Failure, void>> addNote(
      {required NoteEntity noteEntity}) async {
    try {
      final result = await _repository.addNote(noteModel: noteEntity.toModel());

      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      loggy.error('Unexpected error while adding note: $e');
      return Left(ServeiceFailure('Failed to add note: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    try {
      final noteModelsOrFailure = await _repository.getAllNotes();

      return noteModelsOrFailure.fold(
        (failure) => Left(failure),
        (noteModels) {
          final noteEntities = noteModels
              .map((e) => NoteEntity.fromModel(e))
              .toList()
            ..sort(
                (a, b) => (b.creationDateTime).compareTo(a.creationDateTime));
          return Right(noteEntities);
        },
      );
    } catch (e) {
      loggy.error('Unexpected error while fetching notes: $e');
      return Left(DatabaseFailure('Failed to fetch notes: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote({required String noteId}) async {
    try {
      final result = await _repository.deleteNote(noteId: noteId);

      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      loggy.error('Unexpected error while deleting note: $e');
      return Left(ServeiceFailure('Failed to deleting note: ${e.toString()}'));
    }
  }
}
