import 'package:flutter_notes/features/notes/data/models/note/note_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteModel', () {
    test('should create NoteModel instance with correct properties', () {
      final note = NoteModel(
        id: '1',
        creationDateTime: DateTime(2024, 11, 11),
        content: 'Test Note',
      );

      expect(note.creationDateTime, DateTime(2024, 11, 11));
      expect(note.content, 'Test Note');
      expect(note.id, '1');
    });
  });
}
