import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'notes_services_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotesRepository>()])
void main() {
  late MockNotesRepository mockNotesRepository;
  late NotesService notesService;

  final noteEntity = NoteEntity(
    id: '123',
    creationDateTime: DateTime.now(),
    content: 'Sample Note',
  );

  setUp(() {
    mockNotesRepository = MockNotesRepository();
    notesService = NotesService(mockNotesRepository);
  });

  group('NotesService getNotes', () {
    test('should return a sorted list of NoteEntity on success', () async {
      final noteModels = [
        noteEntity.toModel(),
        noteEntity.copyWith(id: '124').toModel(),
      ];

      when(mockNotesRepository.getAllNotes()).thenAnswer(
        (_) async => Right(noteModels),
      );

      final result = await notesService.getNotes();

      result.fold(
        (failure) => fail('Expected Right, got Left with $failure'),
        (notes) {
          expect(notes.length, 2);
          expect(notes.first.id, '124');
          expect(notes.last.id, '123');
        },
      );

      verify(mockNotesRepository.getAllNotes()).called(1);
    });

    test('should return a Failure when repository fails', () async {
      const failureMessage = 'Repository Error';

      when(mockNotesRepository.getAllNotes()).thenAnswer(
        (_) async => Left(DatabaseFailure(failureMessage)),
      );

      final result = await notesService.getNotes();

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockNotesRepository.getAllNotes()).called(1);
    });
  });

  group('NotesService addNote', () {
    test('should return void on successful addition', () async {
      when(mockNotesRepository.addNote(noteModel: anyNamed('noteModel')))
          .thenAnswer((_) async => const Right(null));

      final result = await notesService.addNote(noteEntity: noteEntity);

      expect(result.isRight(), true);

      verify(mockNotesRepository.addNote(noteModel: anyNamed('noteModel')))
          .called(1);
    });

    test('should return a Failure on repository failure', () async {
      const failureMessage = 'Failed to add note';

      when(mockNotesRepository.addNote(noteModel: anyNamed('noteModel')))
          .thenAnswer((_) async => Left(DatabaseFailure(failureMessage)));

      final result = await notesService.addNote(noteEntity: noteEntity);

      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<DatabaseFailure>());
          expect((failure as DatabaseFailure).message, failureMessage);
        },
        (_) => fail('Expected Left, got Right'),
      );

      verify(mockNotesRepository.addNote(noteModel: anyNamed('noteModel')))
          .called(1);
    });
  });
}
