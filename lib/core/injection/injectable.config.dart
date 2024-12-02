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
import '../../features/notes/data/datasources/notes_local_data_source_impl.dart'
    as _i538;
import '../../features/notes/data/repositories/notes_repository.dart' as _i303;
import '../../features/notes/data/repositories/notes_repository_impl.dart'
    as _i10;
import '../../features/notes/domain/services/notes_service/notes_service.dart'
    as _i776;
import '../../features/notes/domain/services/notes_service/notes_service_impl.dart'
    as _i224;
import '../../features/notes/presentation/cubits/add_note_cubit/add_note_cubit.dart'
    as _i61;
import '../../features/notes/presentation/cubits/notes_cubit/notes_cubit.dart'
    as _i374;
import '../data/database/local_database_client.dart' as _i381;
import '../routers/app_router.dart' as _i326;
import 'module/database_module.dart' as _i484;

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
    final databaseModule = _$DatabaseModule();
    gh.singleton<_i326.AppRouter>(() => _i326.AppRouter());
    gh.singleton<_i381.LocalDatabaseClient>(() => databaseModule.instance);
    gh.factory<_i389.NotesLocalDataSource>(
        () => _i538.NotesLocalDataSourceImpl(gh<_i381.LocalDatabaseClient>()));
    gh.factory<_i303.NotesRepository>(
        () => _i10.NotesRepositoryImpl(gh<_i389.NotesLocalDataSource>()));
    gh.factory<_i776.NotesService>(
        () => _i224.NotesServiceImpl(gh<_i303.NotesRepository>()));
    gh.factory<_i61.AddNoteCubit>(
        () => _i61.AddNoteCubit(gh<_i776.NotesService>()));
    gh.factory<_i374.NotesCubit>(
        () => _i374.NotesCubit(gh<_i776.NotesService>()));
    return this;
  }
}

class _$DatabaseModule extends _i484.DatabaseModule {}
