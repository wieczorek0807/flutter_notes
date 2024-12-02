// import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';

// void main() {
//   final noteModel = NoteModel()
//     ..id = 1
//     ..creationDateTime = DateTime(2024, 12, 1)
//     ..content = 'Test Content';

//   group('NoteEntity', () {
//     test('should create NoteEntity from NoteModel', () {
//       final noteEntity = NoteEntity.fromModel(noteModel);

//       expect(noteEntity.id, equals(1));
//       expect(noteEntity.creationDateTime, equals(DateTime(2024, 12, 1)));
//       expect(noteEntity.content, equals('Test Content'));
//     });

//     test('should convert NoteEntity to NoteModel', () {
//       final noteEntity = NoteEntity(
//         id: 1,
//         creationDateTime: DateTime(2024, 12, 1),
//         content: 'Test Content',
//       );

//       final noteModel = noteEntity.toModel();

//       expect(noteModel.id, equals(1));
//       expect(noteModel.creationDateTime, equals(DateTime(2024, 12, 1)));
//       expect(noteModel.content, equals('Test Content'));
//     });

//     test('should handle null id in NoteEntity', () {
//       final noteEntity = NoteEntity(
//         creationDateTime: DateTime(2024, 12, 1),
//         content: 'Test Content',
//       );

//       final noteModel = noteEntity.toModel();

//       expect(noteModel.id, isNotNull);
//       expect(noteModel.creationDateTime, equals(DateTime(2024, 12, 1)));
//       expect(noteModel.content, equals('Test Content'));
//     });
//   });
// }
