import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotesRepository)
class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource _notesDataSource;

  NotesRepositoryImpl(this._notesDataSource);

//tu ma się mapować model ddo dto 
//w data sourece dto do jsona
  @override
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity}) async {
    try {
      return await _notesDataSource.add(noteModel: noteEntity.toModel());
    } catch (e) {
      return Left(RepositoryFailure('Failed to add note: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final value = await _notesDataSource.get();

      return value.fold(
        (l) => Left(l),
        (r) {
          final notesEntities = r.map((e) => NoteEntity.fromModel(e)).toList();
          return Right(notesEntities);
        },
      );
    } catch (e) {
      return Left(RepositoryFailure('Failed to fetch notes: ${e.toString()}'));
    }
  }
}
