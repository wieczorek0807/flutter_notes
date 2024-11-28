import 'package:auto_route/auto_route.dart';
import 'package:flutter_notes/features/notes/presentation/screens/add_note_screen.dart';
import 'package:flutter_notes/features/notes/presentation/screens/notes_screen.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NotesRoute.page, initial: true),
        AutoRoute(page: AddNoteRoute.page),
      ];
}
