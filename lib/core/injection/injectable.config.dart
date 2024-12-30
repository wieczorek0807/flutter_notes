// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/notes/data/datasources/notes_local_data_source.dart'
    as _i389;
import '../../features/notes/data/repositories/notes_repository.dart' as _i303;
import '../../features/notes/domain/services/notes_service/notes_service.dart'
    as _i776;
import '../../features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart'
    as _i61;
import '../../features/notes/presentation/cubits/edit_note_cubit/edit_note_cubit.dart'
    as _i837;
import '../../features/notes/presentation/cubits/notes_cubit/notes_cubit.dart'
    as _i374;
import '../data/database/local_database_client.dart' as _i63;
import '../routers/app_router.dart' as _i326;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i63.LocalDatabaseClient>(() => _i63.LocalDatabaseClient());
    gh.singleton<_i326.AppRouter>(() => _i326.AppRouter());
    gh.factory<_i389.NotesLocalDataSource>(
        () => _i389.NotesLocalDataSource(gh<_i63.LocalDatabaseClient>()));
    gh.factory<_i303.NotesRepository>(
        () => _i303.NotesRepository(gh<_i389.NotesLocalDataSource>()));
    gh.factory<_i776.NotesService>(
        () => _i776.NotesService(gh<_i303.NotesRepository>()));
    gh.factory<_i61.AddNoteCubit>(
        () => _i61.AddNoteCubit(gh<_i776.NotesService>()));
    gh.factory<_i374.NotesCubit>(
        () => _i374.NotesCubit(gh<_i776.NotesService>()));
    gh.factory<_i837.EditNoteCubit>(
        () => _i837.EditNoteCubit(gh<_i776.NotesService>()));
    return this;
  }
}
