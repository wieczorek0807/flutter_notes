import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_notes/core/data/database/database_box.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

typedef DatabaseObject = Map<String, dynamic>;

abstract interface class ILocalDatabaseClient {
  Future<Either<Failure, List<DatabaseObject>>> get({required DatabaseBox box});
  Future<Either<Failure, void>> putAtKey(
      {required DatabaseBox box,
      required DatabaseObject value,
      required String key});
  Future<Either<Failure, void>> clear({required DatabaseBox box});
  Future<Either<Failure, void>> deleteAtKey(
      {required DatabaseBox box, required String key});
}

@singleton
class LocalDatabaseClient with UiLoggy implements ILocalDatabaseClient {
  LocalDatabaseClient();

  Future<void> init() async {
    var path = "/assets/db";
    try {
      if (!kIsWeb) {
        final appDir = await getApplicationDocumentsDirectory();
        path = appDir.path;
      }

      Hive.init(path);

      await Future.wait(DatabaseBox.values.map((box) async {
        await Hive.openBox(box.name);
      }));
    } catch (e) {
      loggy.error('Failed to open Hive database: $e');
      throw DatabaseFailure('Failed to open Hive database: $e');
    }
  }

  Future<Box> _getBox(DatabaseBox box) async {
    try {
      return Hive.box(box.name);
    } catch (e) {
      loggy.error('Failed to get Hive box: $e');
      throw DatabaseFailure('Failed to get Hive box: $e');
    }
  }

  @override
  Future<Either<Failure, void>> putAtKey(
      {required DatabaseBox box,
      required DatabaseObject value,
      required String key}) async {
    try {
      final dbBox = await _getBox(box);
      final dbo = json.encode(value);
      await dbBox.put(key, dbo);
      return const Right(null);
    } catch (e) {
      loggy.error('Failure to add value: $e');
      return Left(DatabaseFailure('Failed to add value: $e'));
    }
  }

  @override
  Future<Either<Failure, List<DatabaseObject>>> get(
      {required DatabaseBox box}) async {
    try {
      final dbBox = await _getBox(box);
      final dbo = dbBox.values.cast<String>().toList();
      final values = dbo.map(json.decode).cast<DatabaseObject>().toList();
      return Right(values);
    } catch (e) {
      loggy.error('Failure to fetch values: $e');
      return Left(DatabaseFailure('Failed to fetch values: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clear({required DatabaseBox box}) async {
    try {
      final dbBox = await _getBox(box);
      await dbBox.clear();
      return const Right(null);
    } catch (e) {
      loggy.error('Failure to clear box: $e');
      return Left(DatabaseFailure('Failed to clear box: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAtKey(
      {required DatabaseBox box, required String key}) async {
    try {
      final dbBox = await _getBox(box);
      await dbBox.delete(key);
      return const Right(null);
    } catch (e) {
      loggy.error('Failure to deleteAtKey: $e');
      return Left(DatabaseFailure('Failed to deleteAtKey: $e'));
    }
  }
}
