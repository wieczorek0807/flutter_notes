import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/models/note_hive/note_model_hive.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotesRepository)
class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource _notesDataSource;

  NotesRepositoryImpl(this._notesDataSource);

//tu ma się mapować model ddo dto
//w data sourece dto do jsona
  @override
  Future<Either<Failure, void>> addNote({required NoteModelHive noteModel}) async {
    try {
      return await _notesDataSource.add(noteDto: noteModel.toDto());
    } catch (e) {
      return Left(RepositoryFailure('Failed to add note: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteModelHive>>> getAllNotes() async {
    print('dupa');
    try {
      final value = await _notesDataSource.get();
      print(value);
      return value.fold(
        (l) => Left(l),
        (r) {
          final noteModels = r.map((e) => NoteModelHive.fromDto(e)).toList();
          return Right(noteModels);
        },
      );
    } catch (e) {
      return Left(RepositoryFailure('Failed to fetch notes: ${e.toString()}'));
    }
  }
}
