import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/notes/notes_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LocalDatabaseClient)
class LocalDatabaseClientImpl implements LocalDatabaseClient {
  late Future<Isar> db;

  LocalDatabaseClientImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    try {
      if (Isar.instanceNames.isEmpty) {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [NotesModelSchema],
          directory: dir.path,
        );
      }
      return Future.value(Isar.getInstance());
    } catch (e) {
      throw DatabaseFailure('Failed to open Isar database: $e');
    }
  }

  @override
  Future<Either<Failure, List<NotesModel>>> getNotes() async {
    try {
      final isar = await db;
      final notes = await isar.notesModels.where().sortByCreationDateTimeDesc().findAll();
      return Right(notes);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get notes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> addNotes({required NotesModel notesModel}) async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.notesModels.put(notesModel);
      });
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add note: $e'));
    }
  }
}
