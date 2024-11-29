import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/usecases/notes_usecase/notes_usecase.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotesUsecase)
class NotesUsecaseImpl implements NotesUsecase {
  final NotesRepository _repository;

  NotesUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity}) async {
    return await _repository.addNote(noteEntity: noteEntity);
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    return await _repository.getAllNotes();
  }
}
