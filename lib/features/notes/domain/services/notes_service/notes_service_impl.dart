import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: NotesService)
class NotesServiceImpl implements NotesService {
  final NotesRepository _repository;

  NotesServiceImpl(this._repository);

  @override
  Future<Either<Failure, void>> addNote({required NoteEntity noteEntity}) async {
    return await _repository.addNote(noteModel: noteEntity.toModel());
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() async {
    final noteModelsOrFailure = await _repository.getAllNotes();
    
    return noteModelsOrFailure.fold((l) {
      return Left(DatabaseFailure('dupa3'));
    }, (r) {
      final noteEntities = r.map((e) => NoteEntity.fromModel(e)).toList();
      return Right(noteEntities);
    });
  }
}
