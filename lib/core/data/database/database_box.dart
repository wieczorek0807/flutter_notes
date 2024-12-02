enum DatabaseBox {
  notes._(name: 'notes_box');

  const DatabaseBox._({required this.name});

  final String name;
}
