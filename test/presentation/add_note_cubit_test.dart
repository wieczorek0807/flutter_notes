// import 'dart:async';

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_notes/core/errors/failure.dart';
// import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_notes/features/notes/domain/services/notes_usecase/notes_service.dart';
// import 'package:flutter_notes/features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart';
// import 'package:flutter_notes/features/notes/presentation/cubits/notes_cubit/notes_cubit.dart';
// import 'package:flutter_notes/core/routers/app_router.dart';
// import 'package:dartz/dartz.dart';

// import 'add_note_cubit_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<NotesService>()])
// void main() {
//   late AddNoteCubit addNoteCubit;
//   late MokeNoteService mokeNoteService;

//   setUp(() {
//     mokeNoteService = MokeNoteService();
//     addNoteCubit = AddNoteCubit(mokeNoteService);
//   });

//   group('AddNoteCubit', () {
//     test('initial state should be AddNoteState.initial()', () {
//       expect(addNoteCubit.state, const AddNoteState.initial());
//     });

//     blocTest<AddNoteCubit, AddNoteState>(
//       'emits [AddNoteState.loading, AddNoteState.error] when content is empty',
//       build: () => addNoteCubit,
//       act: (cubit) => cubit.saveNote(''),
//       expect: () => [
//         const AddNoteState.loading(),
//         const AddNoteState.error(message: 'Note cannot be empty'),
//       ],
//       verify: (_) {
//         verifyNever(mokeNoteService.addNote(noteEntity: anyNamed('noteEntity')));
//       },
//     );

//     blocTest<AddNoteCubit, AddNoteState>(
//       'emits [AddNoteState.loading, AddNoteState.error] when usecase fails',
//       build: () {
//         when(mokeNoteService.addNote(noteEntity: anyNamed('noteEntity'))).thenThrow('Unexpected error');
//         return addNoteCubit;
//       },
//       act: (cubit) => cubit.saveNote('a'),
//       expect: () => [
//         const AddNoteState.loading(),
//         const AddNoteState.error(message: 'An error occurred: Unexpected error'),
//       ],
//       verify: (_) {
//         verify(mokeNoteService.addNote(noteEntity: anyNamed('noteEntity'))).called(1);
//       },
//     );

//     blocTest<AddNoteCubit, AddNoteState>(
//       'emits [AddNoteState.loading, AddNoteState.success] when usecase succeeds',
//       build: () {
//         when(mokeNoteService.addNote(noteEntity: argThat(isNotNull, named: 'noteEntity')))
//             .thenAnswer((a) async => const Right(null));

//         // when(mockNotesUsecase.addNote(noteEntity: anyNamed('noteEntity')))
//         //     .thenAnswer((_) async => const Right(null));

//         // when(mockNotesCubit.getNotes()).thenAnswer((_) async => Future(() => null));
//         // when(mockAppRouter.maybePop()).thenAnswer((_) => Future(true as FutureOr<bool> Function()));
//         return addNoteCubit;
//       },
//       act: (cubit) => cubit.saveNote('a'),
//       expect: () => [
//         const AddNoteState.loading(),
//       ],
//       verify: (_) {
//         // verify(mockNotesUsecase).called(1);
//         verify(mokeNoteService.getNotes()).called(1);
//         // verify(mockAppRouter.maybePop()).called(1);
//       },
//     );

//     blocTest<AddNoteCubit, AddNoteState>(
//       'emits [AddNoteState.loading, AddNoteState.error] when an unexpected error occurs',
//       build: () {
//         when(mokeNoteService.addNote(noteEntity: anyNamed('noteEntity'))).thenThrow('Unexpected error');
//         return addNoteCubit;
//       },
//       act: (cubit) => cubit.saveNote('Test note'),
//       expect: () => [
//         const AddNoteState.loading(),
//         const AddNoteState.error(message: 'An error occurred: Unexpected error'),
//       ],
//       verify: (_) {
//         verify(mokeNoteService.addNote(noteEntity: anyNamed('noteEntity'))).called(1);
//       },
//     );
//   });
// }
