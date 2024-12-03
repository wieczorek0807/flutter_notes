import 'package:flutter_notes/features/notes/data/dto/note_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoteDoto', () {
    test('should create NoteDto instance with correct properties', () {
      final note = NoteDto(
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
