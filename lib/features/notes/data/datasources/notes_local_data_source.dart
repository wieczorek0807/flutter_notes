import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/data/database/database_box.dart';
import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';

abstract interface class INotesLocalDataSource {
  Future<Either<Failure, List<NoteDto>>> get();
  Future<Either<Failure, void>> add({required NoteDto noteDto});
}

@injectable
class NotesLocalDataSource with UiLoggy implements INotesLocalDataSource {
  final LocalDatabaseClient _localDatabaseClient;
  NotesLocalDataSource(this._localDatabaseClient);

  @override
  Future<Either<Failure, List<NoteDto>>> get() async {
    try {
      final value = await _localDatabaseClient.get(box: DatabaseBox.notes);

      return value.fold(
        (failure) => Left(failure),
        (notes) {
          final noteDtos = notes.map((e) => NoteDto.fromJson(e)).toList();
          return Right(noteDtos);
        },
      );
    } catch (e, st) {
      loggy.error('Error while getting notes: $e', e, st);
      return Left(LocalDataSourceFailure('An unexpected error occurred while fetching notes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> add({required NoteDto noteDto}) async {
    try {
      final noteJson = noteDto.toJson();
      final result = await _localDatabaseClient.add(box: DatabaseBox.notes, value: noteJson);

      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e, st) {
      loggy.error('Error while adding note: $e', e, st);
      return Left(LocalDataSourceFailure('An unexpected error occurred while adding the note: $e'));
    }
  }
}
