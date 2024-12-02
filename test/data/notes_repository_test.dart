// import 'package:flutter_notes/features/notes/data/datasources/notes_local_data_source.dart';
// import 'package:flutter_notes/features/notes/data/repositories/notes_repository_impl.dart';
// import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_notes/core/errors/failure.dart';
// import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
// import 'package:mockito/annotations.dart';

// import 'notes_repository_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<NotesLocalDataSource>()])
// void main() {
//   late MockNotesLocalDataSource mockNotesLocalDataSource;
//   late NotesRepositoryImpl notesRepositoryImpl;

//   final noteModel = NoteModel()
//     ..id = 1
//     ..content = 'Test note'
//     ..creationDateTime = DateTime(2011, 11, 11);

//   final noteEntity = NoteEntity(creationDateTime: DateTime(2011, 11, 11), content: 'Test note', id: 1);

//   setUp(() {
//     mockNotesLocalDataSource = MockNotesLocalDataSource();
//     notesRepositoryImpl = NotesRepositoryImpl(mockNotesLocalDataSource);
//   });

//   group('notesRepositoryImpl get', () {
//     test('should return a list of NoteEntity when getAllNotes is successful', () async {
//       when(mockNotesLocalDataSource.get()).thenAnswer((_) async => Right([noteModel]));

//       final result = await notesRepositoryImpl.getAllNotes();

//       result.fold(
//         (failure) => fail('test failed with failure: $failure'),
//         (value) {
//           expect(value, [noteEntity]);
//         },
//       );

//       verify(mockNotesLocalDataSource.get()).called(1);
//     });

//     test('should return a Failure on error', () async {
//       const failureMessage = 'Database Error';
//       when(mockNotesLocalDataSource.get()).thenAnswer(
//         (_) async => Left(DatabaseFailure(failureMessage)),
//       );

//       final result = await notesRepositoryImpl.getAllNotes();

//       expect(result.isLeft(), true);
//       result.fold(
//         (failure) {
//           expect(failure, isA<DatabaseFailure>());
//           expect((failure as DatabaseFailure).message, failureMessage);
//         },
//         (_) => fail('Expected Left, got Right'),
//       );

//       verify(mockNotesLocalDataSource.get()).called(1);
//     });
//   });

//   group('notesRepositoryImpl add', () {
//     test('should return void on successful add', () async {
//       when(mockNotesLocalDataSource.add(noteModel: anyNamed('noteModel'))).thenAnswer(
//         (_) async => const Right(null),
//       );

//       final result = await notesRepositoryImpl.addNote(noteEntity: noteEntity);

//       expect(result.isRight(), true);

//       verify(mockNotesLocalDataSource.add(noteModel: anyNamed('noteModel'))).called(1);
//     });

//     test('should return a Failure on error', () async {
//       const failureMessage = 'Failed to add note';
//       when(mockNotesLocalDataSource.add(noteModel: anyNamed('noteModel'))).thenAnswer(
//         (_) async => Left(DatabaseFailure(failureMessage)),
//       );

//       final result = await notesRepositoryImpl.addNote(noteEntity: noteEntity);

//       expect(result.isLeft(), true);
//       result.fold(
//         (failure) {
//           expect(failure, isA<DatabaseFailure>());
//           expect((failure as DatabaseFailure).message, failureMessage);
//         },
//         (_) => fail('Expected Left, got Right'),
//       );

//       verify(mockNotesLocalDataSource.add(noteModel: anyNamed('noteModel'))).called(1);
//     });
//   });
// }
