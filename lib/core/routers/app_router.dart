import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/features/notes/presentation/screens/add_note_screen.dart';
import 'package:flutter_notes/features/notes/presentation/screens/notes_screen.dart';
import 'package:injectable/injectable.dart';

import '../../features/notes/domain/entities/note_entity/note_entity.dart';
import '../../features/notes/presentation/screens/edit_note_screen.dart';

part 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NotesRoute.page, initial: true),
        AutoRoute(page: AddNoteRoute.page),
        AutoRoute(page: EditNoteRoute.page)
      ];
}
