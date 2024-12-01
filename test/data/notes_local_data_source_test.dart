import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:mockito/annotations.dart';

import 'notes_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalDatabaseClient>()])
void main() {
  late MockLocalDatabaseClient mockLocalDatabaseClient;
  late NotesLocalDataSourceImpl notesLocalDataSource;

  setUp(() {
    mockLocalDatabaseClient = MockLocalDatabaseClient();
    notesLocalDataSource = NotesLocalDataSourceImpl(mockLocalDatabaseClient);
  });

  group('NotesLocalDataSourceImpl get', () {
    final noteModel = NoteModel()
      ..content = 'Test note'
      ..creationDateTime = DateTime.now();

    test('should return a list of NoteModel when getNotes is successful', () async {
      when(mockLocalDatabaseClient.getNotes()).thenAnswer((_) async => Right([noteModel]));

      final result = await notesLocalDataSource.get();

      result.fold(
        (failure) => fail('test failed with failure: $failure'),
        (value) {
          expect(value, [noteModel]);
        },
      );

      verify(mockLocalDatabaseClient.getNotes()).called(1);
    });

    test('should return a Failure on error', () async {
      const failureMessage = 'Database Error';
      when(mockLocalDatabaseClient.getNotes()).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesLocalDataSource.get();

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockLocalDatabaseClient.getNotes()).called(1);
    });
  });

  group('NotesLocalDataSourceImpl add', () {
    final note = NoteModel()..content = 'New Note';
    test('should return void on successful add', () async {
      when(mockLocalDatabaseClient.addNote(noteModel: note)).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await notesLocalDataSource.add(noteModel: note);

      expect(result.isRight(), true);

      verify(mockLocalDatabaseClient.addNote(noteModel: note)).called(1);
    });

    test('should return a Failure on error', () async {
      const failureMessage = 'Failed to add note';
      when(mockLocalDatabaseClient.addNote(noteModel: note)).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)), // Error
      );

      final result = await notesLocalDataSource.add(noteModel: note);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockLocalDatabaseClient.addNote(noteModel: note)).called(1);
    });
  });
}
