import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';

abstract class NotesUsecase {
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity});
}
