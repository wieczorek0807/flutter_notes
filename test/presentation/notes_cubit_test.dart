import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'add_note_cubit_test.mocks.dart';

void main() {
  late MockNotesService mockNotesService;

  final noteEntity = NoteEntity.createNewNote(
    content: 'Test Note',
  );

  setUp(() {
    mockNotesService = MockNotesService();
  });

  group('NotesCubit', () {
    blocTest<NotesCubit, NotesState>(
      'emits [loaded] when getNotes succeeds with data after initialization',
      build: () {
        when(mockNotesService.getNotes()).thenAnswer((_) async => Right([noteEntity]));
        return NotesCubit(mockNotesService);
      },
      expect: () => [
        NotesState.loaded(noteEntities: [noteEntity]),
      ],
      verify: (_) {
        verify(mockNotesService.getNotes()).called(1);
      },
    );

    blocTest<NotesCubit, NotesState>(
      'emits [initial] when getNotes returns empty list after initialization',
      build: () {
        when(mockNotesService.getNotes()).thenAnswer((_) async => const Right([]));
        return NotesCubit(mockNotesService);
      },
      expect: () => [
        const NotesState.initial(),
      ],
      verify: (_) {
        verify(mockNotesService.getNotes()).called(1);
      },
    );

    blocTest<NotesCubit, NotesState>(
      'emits [error] when getNotes fails after initialization',
      build: () {
        when(mockNotesService.getNotes())
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to fetch notes')));
        return NotesCubit(mockNotesService);
      },
      expect: () => [
        NotesState.error(message: 'Failed to fetch notes'),
      ],
      verify: (_) {
        verify(mockNotesService.getNotes()).called(1);
      },
    );
  });
}
