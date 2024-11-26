import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/notes/notes_model.dart';

abstract class LocalDatabaseClient {
  Future<Either<Failure, List<NotesModel>>> getNotes();
  Future<void> addNotes({required NotesModel notesModel});
}
