// import 'package:flutter_notes/features/notes/data/repositories/notes_repository.dart';
// import 'package:flutter_notes/features/notes/domain/services/notes_usecase/notes_service.dart';
// import 'package:flutter_notes/features/notes/domain/services/notes_usecase/notes_service_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:flutter_notes/core/errors/failure.dart';
// import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
// import 'package:dartz/dartz.dart';
// import 'package:mockito/mockito.dart';
// import 'notes_usecase_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<NotesRepository>()])
// void main() {
//   late NotesService notesService;
//   late MockNotesRepository mockNotesRepository;

//   setUp(() {
//     mockNotesRepository = MockNotesRepository();
//     notesService = NotesService(mockNotesRepository);
//   });

//   group('NotesUsecase', () {
//     test('should return a list of NoteEntity when getAllNotes is called successfully', () async {
//       final noteEntity = NoteEntity(
//         id: 1,
//         creationDateTime: DateTime(2024, 12, 1),
//         content: 'Test note',
//       );

//       when(mockNotesRepository.getAllNotes()).thenAnswer((_) async => Right([noteEntity]));

//       final result = await notesService.getNotes();

//       expect(result.isRight(), true);
//       result.fold(
//         (failure) => fail('Expected success but got failure'),
//         (notes) {
//           expect(notes, isA<List<NoteEntity>>());
//           expect(notes.length, 1);
//           expect(notes.first.content, 'Test note');
//         },
//       );
//     });

//     test('should return Failure when getAllNotes fails', () async {
//       when(mockNotesRepository.getAllNotes()).thenAnswer((_) async => Left(DatabaseFailure('Error')));

//       final result = await notesService.getNotes();

//       expect(result.isLeft(), true);
//       result.fold(
//         (failure) {
//           expect(failure, isA<Failure>());
//           expect(failure.message, 'Error');
//         },
//         (notes) => fail('Expected failure but got success'),
//       );
//     });

//     test('should successfully add a note', () async {
//       final noteEntity = NoteEntity(
//         id: 1,
//         creationDateTime: DateTime(2024, 12, 1),
//         content: 'New note',
//       );

//       when(mockNotesRepository.addNote(noteEntity: noteEntity)).thenAnswer((_) async => const Right(null));

//       final result = await notesService.addNote(noteEntity: noteEntity);

//       expect(result.isRight(), true);
//     });

//     test('should return Failure when addNote fails', () async {
//       final noteEntity = NoteEntity(
//         id: 1,
//         creationDateTime: DateTime(2024, 12, 1),
//         content: 'New note',
//       );

//       when(mockNotesRepository.addNote(noteEntity: noteEntity))
//           .thenAnswer((_) async => Left(DatabaseFailure('Error adding note')));

//       final result = await notesService.addNote(noteEntity: noteEntity);

//       expect(result.isLeft(), true);
//       result.fold(
//         (failure) {
//           expect(failure, isA<Failure>());
//           expect(failure.message, 'Error adding note');
//         },
//         (_) => fail('Expected failure but got success'),
//       );
//     });
//   });
// }
