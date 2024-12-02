import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/note_hive/note_model_hive.dart';

abstract interface class NotesRepository {
  Future<Either<Failure, List<NoteModelHive>>> getAllNotes();
  Future<Either<Failure, void>> addNote({required NoteModelHive noteModel});
}
