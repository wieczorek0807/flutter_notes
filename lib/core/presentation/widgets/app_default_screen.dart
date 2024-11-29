import 'package:flutter/material.dart';

class AppDefaultScreen extends StatelessWidget {
  const AppDefaultScreen({required this.title, required this.body, super.key, this.floatingActionButton});
  final Widget body;
  final Widget? floatingActionButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
              child: body,
            ),
          ),
        ),
        floatingActionButton: floatingActionButton);
  }
}
