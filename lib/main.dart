import 'package:flutter/material.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/presentation/styles/styles.dart';
import 'package:flutter_notes/core/provider/global_provider.dart';
import 'package:flutter_notes/core/routers/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = getIt<AppRouter>();

    return GlobalProvider(
      child: MaterialApp.router(
        theme: AppTheme.defaultAppTheme,
        routerConfig: appRouter.config(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
