import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @singleton
  LocalDatabaseClient get instance => LocalDatabaseClient();
}
