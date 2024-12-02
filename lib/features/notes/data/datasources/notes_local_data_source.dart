import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';

abstract class NotesLocalDataSource {
  Future<Either<Failure, List<NoteDto>>> get();
  Future<Either<Failure, void>> add({required NoteDto noteDto});
}
