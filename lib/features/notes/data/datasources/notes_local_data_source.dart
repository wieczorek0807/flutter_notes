import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';

abstract class NotesLocalDataSource {
  Future<Either<Failure, List<NoteModel>>> get();
  Future<Either<Failure, void>> add({required NoteModel noteModel});
}
