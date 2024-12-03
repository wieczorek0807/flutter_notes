import 'package:flutter_notes/features/notes/domain/entities/note_entity/note_entity.dart';
import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteEntity', () {
    test('should create a new note with valid data using createNewNote', () {
      const content = 'Test Note Content';

      final note = NoteEntity.createNewNote(content: content);

      expect(note.id, isNotNull);
      expect(note.content, content.trim());
      expect(
        DateTime.tryParse(note.creationDateTime),
        isA<DateTime>(),
      );
    });

    test('should correctly convert from NoteModel to NoteEntity using fromModel', () {
      final noteModel = NoteModel(
        id: '123',
        creationDateTime: DateTime(2022, 12, 3, 14, 30),
        content: 'Model Content',
      );

      final noteEntity = NoteEntity.fromModel(noteModel);

      expect(noteEntity.id, noteModel.id);
      expect(noteEntity.content, noteModel.content);
      expect(noteEntity.creationDateTime, '2022-12-03 14:30');
    });

    test('should correctly convert from NoteEntity to NoteModel using toModel', () {
      final noteEntity = NoteEntity(
        id: '123',
        creationDateTime: '2022-12-03 14:30',
        content: 'Entity Content',
      );

      final noteModel = noteEntity.toModel();

      expect(noteModel.id, noteEntity.id);
      expect(noteModel.content, noteEntity.content);
      expect(noteModel.creationDateTime, DateTime(2022, 12, 3, 14, 30));
    });

    test('should trim content in createNewNote', () {
      const content = '  Padded Content  ';

      final note = NoteEntity.createNewNote(content: content);

      expect(note.content, 'Padded Content');
    });

    test('should handle invalid datetime format in creationDateTime gracefully', () {
      final noteEntity = NoteEntity(
        id: '123',
        creationDateTime: 'invalid-date',
        content: 'Content',
      );

      expect(
        () => noteEntity.toModel(),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
