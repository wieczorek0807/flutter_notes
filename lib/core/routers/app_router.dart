import 'package:auto_route/auto_route.dart';
import 'package:flutter_notes/features/notes/presentation/screens/new_note_screen.dart';
import 'package:flutter_notes/features/notes/presentation/screens/notes_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NotesRoute.page, initial: true),
        AutoRoute(page: NewNoteRoute.page, fullscreenDialog: true),
      ];
}
