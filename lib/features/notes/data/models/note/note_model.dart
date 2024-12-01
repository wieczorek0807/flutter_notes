import 'package:isar/isar.dart';
part 'note_model.g.dart';

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  late DateTime creationDateTime;
  late String content;
}
