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

  @override
  Future<void> addNote({required NoteEntity noteEntity}) async {
    _notesDataSource.add(noteModel: noteEntity.toModel());
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    final value = await _notesDataSource.get();

    return value.fold(
      (l) => Left(l),
      (r) {
        final notesEnties = r.map((e) => NoteEntity.fromModel(e)).toList();
        return Right(notesEnties);
      },
    );
  }
}
