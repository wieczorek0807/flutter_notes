import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'notes_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotesLocalDataSource>()])
void main() {
  late MockNotesLocalDataSource mockNotesLocalDataSource;
  late NotesRepository notesRepository;

  final noteDto = NoteDto(
    id: '1',
    creationDateTime: DateTime(2011, 11, 11),
    content: 'Test note',
  );

  final noteModel = NoteModel(
    id: '1',
    content: 'Test note',
    creationDateTime: DateTime(2011, 11, 11),
  );

  setUp(() {
    mockNotesLocalDataSource = MockNotesLocalDataSource();
    notesRepository = NotesRepository(mockNotesLocalDataSource);
  });

  group('notesRepository getAllNotes', () {
    test('should return a list of NoteEntity when successful', () async {
      when(mockNotesLocalDataSource.get()).thenAnswer((_) async => Right([noteDto]));

      final result = await notesRepository.getAllNotes();

      result.fold(
        (failure) => fail('Test failed with failure: $failure'),
        (notes) {
          expect(notes, [noteModel]);
        },
      );

      verify(mockNotesLocalDataSource.get()).called(1);
    });

    test('should return a Failure when an error occurs', () async {
      const failureMessage = 'Database Error';
      when(mockNotesLocalDataSource.get()).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesRepository.getAllNotes();

      expect(result.isLeft(), true);

      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockNotesLocalDataSource.get()).called(1);
    });
  });

  group('notesRepository addNote', () {
    test('should return void on successful add', () async {
      when(mockNotesLocalDataSource.add(noteDto: anyNamed('noteDto')))
          .thenAnswer((_) async => const Right(null));

      final result = await notesRepository.addNote(noteModel: noteModel);

      expect(result.isRight(), true);

      verify(mockNotesLocalDataSource.add(noteDto: anyNamed('noteDto'))).called(1);
    });

    test('should return a Failure when an error occurs', () async {
      const failureMessage = 'Failed to add note';
      when(mockNotesLocalDataSource.add(noteDto: anyNamed('noteDto'))).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesRepository.addNote(noteModel: noteModel);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockNotesLocalDataSource.add(noteDto: anyNamed('noteDto'))).called(1);
    });
  });
}
