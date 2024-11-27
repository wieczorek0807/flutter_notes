import 'package:flutter/material.dart';
import 'package:flutter_notes/core/injection/injectable.dart';
import 'package:flutter_notes/core/presentation/styles/styles.dart';
import 'package:flutter_notes/core/routers/app_router.dart';

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

    return MaterialApp.router(
      theme: AppTheme.defaultAppTheme,
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
