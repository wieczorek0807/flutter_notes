import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/notes/notes_model.dart';

abstract class NotesLocalDataSource {
  Future<Either<Failure, List<NotesModel>>> get();
  Future<void> add({required NotesModel medicationModel});
}
