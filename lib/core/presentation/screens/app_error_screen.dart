import 'package:flutter/material.dart';
import 'package:flutter_notes/core/extensions/build_context_ext.dart';
import 'package:flutter_notes/core/presentation/widgets/app_default_screen.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDefaultScreen(
      title: context.appLocalizations.errorScreenTitle,
      body: Center(child: Text(context.appLocalizations.errorScreenMessage)),
    );
  }
}
