import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_notes/core/errors/failure.dart';
import 'package:flutter_notes/features/notes/domain/services/notes_service/notes_service.dart';
import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_note_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotesService>()])
void main() {
  late MockNotesService mockNotesService;
  late AddNoteCubit addNoteCubit;

  setUp(() {
    mockNotesService = MockNotesService();
    addNoteCubit = AddNoteCubit(mockNotesService);
  });

  group('AddNoteCubit', () {
    test('initial state should be AddNoteState.initial', () {
      expect(addNoteCubit.state, const AddNoteState.initial());
    });

    blocTest<AddNoteCubit, AddNoteState>(
      'emits [loading, success] when saveNote succeeds',
      build: () {
        when(mockNotesService.addNote(noteEntity: anyNamed('noteEntity')))
            .thenAnswer((_) async => const Right(null));
        return addNoteCubit;
      },
      act: (cubit) => cubit.saveNote('Test Note'),
      expect: () => [
        const AddNoteState.loading(),
        const AddNoteState.success(),
      ],
      verify: (_) {
        verify(mockNotesService.addNote(noteEntity: anyNamed('noteEntity'))).called(1);
      },
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'emits [loading, error] when note content is empty',
      build: () => addNoteCubit,
      act: (cubit) => cubit.saveNote(''),
      expect: () => [
        const AddNoteState.loading(),
        const AddNoteState.error(message: 'Note cannot be empty'),
      ],
      verify: (_) {
        verifyNever(mockNotesService.addNote(noteEntity: anyNamed('noteEntity')));
      },
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'emits [loading, error] when saveNote fails with a Failure',
      build: () {
        when(mockNotesService.addNote(noteEntity: anyNamed('noteEntity'))).thenAnswer(
          (_) async => Left(ServeiceFailure('Failed to save note')),
        );
        return addNoteCubit;
      },
      act: (cubit) => cubit.saveNote('Test Note'),
      expect: () => [
        const AddNoteState.loading(),
        const AddNoteState.error(message: 'Failed to save note'),
      ],
      verify: (_) {
        verify(mockNotesService.addNote(noteEntity: anyNamed('noteEntity'))).called(1);
      },
    );

    blocTest<AddNoteCubit, AddNoteState>(
      'emits [loading, error] when an exception occurs',
      build: () {
        when(mockNotesService.addNote(noteEntity: anyNamed('noteEntity')))
            .thenThrow(Exception('Unexpected error'));
        return addNoteCubit;
      },
      act: (cubit) => cubit.saveNote('Test Note'),
      expect: () => [
        const AddNoteState.loading(),
        AddNoteState.error(message: 'An error occurred: Exception: Unexpected error'),
      ],
      verify: (_) {
        verify(mockNotesService.addNote(noteEntity: anyNamed('noteEntity'))).called(1);
      },
    );
  });
}
