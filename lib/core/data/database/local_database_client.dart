import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/data/database/database_box.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

typedef DatabaseObject = Map<String, dynamic>;

abstract interface class ILocalDatabaseClient {
  Future<Either<Failure, List<String>>> get({required DatabaseBox box});
  Future<Either<Failure, void>> add({required DatabaseBox box, required String json});
}

class LocalDatabaseClient with UiLoggy implements ILocalDatabaseClient {
  LocalDatabaseClient();


  Future<void> init() async {
    try {
      loggy.debug('_init start');
      await getApplicationDocumentsDirectory().then((dir) => Hive.init(dir.path));

      for (var box in DatabaseBox.values) {
        await Hive.openBox(box.name);
      }
      loggy.debug('Hive Boxes have been successfully opened');
      return Future.value('asd');
    } catch (e) {
      loggy.error('Failed to open Hive database: $e');
      throw DatabaseFailure('Failed to open Hive database: $e');
    }
  }

  @override
  Future<Either<Failure, void>> add({
    required DatabaseBox box,
    required String json,
  }) async {
    loggy.debug('add was called');
    try {
      final dbBox = Hive.box(box.name);
      await dbBox.add(json);
      return const Right(null); // Sukces, zwracamy `null` jako wartość w przypadku `Right`
    } catch (e, st) {
      loggy.error('Failure to put value', e, st);
      return Left(DatabaseFailure('Failed to add note: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> get({
    required DatabaseBox box,
  }) async {
    loggy.debug('get was called');
    try {
      final dbBox = Hive.box(box.name);

      // Pobieranie wszystkich wartości jako listy
      final values = dbBox.values.cast<String>().toList();

      if (values.isEmpty) {
        return Left(DatabaseFailure('No records found'));
      }
      return Right(values);
    } catch (e, st) {
      // Logowanie błędu

      loggy.error('Failure to get value', e, st);
      return Left(DatabaseFailure('Failed to fetch notes: $e'));
    }
  }
}
