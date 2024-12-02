import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/data/database/database_box.dart';
import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotesLocalDataSource)
class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final LocalDatabaseClient _localDatabaseClient;
  NotesLocalDataSourceImpl(this._localDatabaseClient);

  @override
  Future<Either<Failure, List<NoteDto>>> get() async {
    final value = await _localDatabaseClient.get(box: DatabaseBox.notes);

    return value.fold((l) {
      return Left(DatabaseFailure('NotesLocalDataSourceImpl '));
    }, (r) {
      final noteDtos = r.map((e) => NoteDto.fromJson(jsonDecode(e))).toList();
      return Right(noteDtos);
    });
  }

  @override
  Future<Either<Failure, void>> add({required NoteDto noteDto}) async {
    final noteJson = jsonEncode(noteDto.toJson());
    return await _localDatabaseClient.add(box: DatabaseBox.notes, json: noteJson);
  }
}
