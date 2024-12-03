import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';

import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_notes/core/data/database/local_database_client.dart';
import 'package:mockito/annotations.dart';

import 'notes_local_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalDatabaseClient>()])
void main() {
  late MockLocalDatabaseClient mockLocalDatabaseClient;
  late NotesLocalDataSource notesLocalDataSource;

  setUp(() {
    mockLocalDatabaseClient = MockLocalDatabaseClient();
    notesLocalDataSource = NotesLocalDataSource(mockLocalDatabaseClient);
  });

  final noteDto = NoteDto(
    id: '1',
    creationDateTime: DateTime(2024, 11, 11),
    content: 'Test Note',
  );
  group('NotesLocalDataSource get', () {
    test('should return a list of NoteDto when getNotes is successful', () async {
      when(mockLocalDatabaseClient.get(box: anyNamed('box')))
          .thenAnswer((_) async => Right([noteDto.toJson()]));

      final result = await notesLocalDataSource.get();

      result.fold(
        (failure) => fail('test failed with failure: $failure'),
        (value) {
          expect(value, [noteDto]);
        },
      );

      verify(mockLocalDatabaseClient.get(box: anyNamed('box'))).called(1);
    });

    test('should return a Failure on error', () async {
      const failureMessage = 'Database Error';
      when(mockLocalDatabaseClient.get(box: anyNamed('box'))).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesLocalDataSource.get();

      expect(result.isLeft(), true);
      result.fold(
        (value) {
          expect(value, isA<Failure>());
          expect((value as DatabaseFailure).message, failureMessage, reason: "Expected Left, got Right'");
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockLocalDatabaseClient.get(box: anyNamed('box'))).called(1);
    });
  });

  group('NotesLocalDataSource add', () {
    test('should return void on successful add', () async {
      when(mockLocalDatabaseClient.add(value: anyNamed('value'), box: anyNamed('box'))).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await notesLocalDataSource.add(noteDto: noteDto);

      expect(result.isRight(), true);

      verify(mockLocalDatabaseClient.add(value: anyNamed('value'), box: anyNamed('box'))).called(1);
    });

    test('should return a Failure on error', () async {
      const failureMessage = 'Failed to add note';
      when(mockLocalDatabaseClient.add(value: anyNamed('value'), box: anyNamed('box'))).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesLocalDataSource.add(noteDto: noteDto);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockLocalDatabaseClient.add(value: anyNamed('value'), box: anyNamed('box'))).called(1);
    });
  });
}
