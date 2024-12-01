import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_usecase/notes_service.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: NotesService)
class NotesServiceImpl implements NotesService {
  final NotesRepository _repository;

  NotesServiceImpl(this._repository);

  @override
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity}) async {
    //form entiti to entit w service

    return await _repository.addNote(noteEntity: noteEntity);
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    return await _repository.getAllNotes();
  }
}
