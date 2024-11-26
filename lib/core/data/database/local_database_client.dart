import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';

abstract class LocalDatabaseClient {
  Future<Either<Failure, List<NoteModel>>> getNotes();
  Future<void> addNote({required NoteModel noteModel});
}
