import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotesLocalDataSource)
class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final LocalDatabaseClient _localDatabaseClient;
  NotesLocalDataSourceImpl(this._localDatabaseClient);

  @override
  Future<Either<Failure, List<NoteModel>>> get() async {
    return await _localDatabaseClient.getNotes();
  }

  @override
  Future<Either<Failure, void>> add({required NoteModel noteModel}) async {
    return await _localDatabaseClient.addNote(noteModel: noteModel);
  }
}
