import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/models/note_hive/note_model_hive.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';

abstract interface class INotesRepository {
  Future<Either<Failure, List<NoteModelHive>>> getAllNotes();
  Future<Either<Failure, void>> addNote({required NoteModelHive noteModel});
}

@injectable
class NotesRepository with UiLoggy implements INotesRepository {
  final NotesLocalDataSource _notesDataSource;

  NotesRepository(this._notesDataSource);

  @override
  Future<Either<Failure, void>> addNote({required NoteModelHive noteModel}) async {
    try {
      final result = await _notesDataSource.add(noteDto: noteModel.toDto());
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      loggy.error('Unexpected error while adding note: $e');
      return Left(RepositoryFailure('Failed to add note: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteModelHive>>> getAllNotes() async {
    try {
      final value = await _notesDataSource.get();
      return value.fold(
        (failure) => Left(failure),
        (notes) {
          final noteModels = notes.map((e) => NoteModelHive.fromDto(e)).toList();
          return Right(noteModels);
        },
      );
    } catch (e) {
      loggy.error('Unexpected error while fetching notes: $e');
      return Left(RepositoryFailure('Failed to fetch notes: ${e.toString()}'));
    }
  }
}
